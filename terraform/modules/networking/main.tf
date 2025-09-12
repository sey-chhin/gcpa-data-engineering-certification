############################
# VPC (custom-mode baseline)
############################
resource "google_compute_network" "vpc" {
  project                 = var.project_id
  name                    = var.vpc_name
  auto_create_subnetworks = false
  routing_mode            = "REGIONAL"
  # labels                = var.labels
}

#############################################
# Subnets (PGA enabled + Flow Logs enabled)
#############################################
resource "google_compute_subnetwork" "subs" {
  for_each                 = var.subnet_cidrs           # e.g., { primary = "10.150.0.0/20" }
  project                  = var.project_id
  region                   = var.region
  name                     = "${var.vpc_name}-${each.key}"
  ip_cidr_range            = each.value
  network                  = google_compute_network.vpc.id
  private_ip_google_access = false
  stack_type               = "IPV4_ONLY"
  purpose                  = "PRIVATE"

  # VPC Flow Logs for visibility/troubleshooting
  log_config {
    aggregation_interval = "INTERVAL_5_MIN"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
    # metadata_fields    = []  # optional, provider >= 4.61
  }
  # labels               = var.labels
}

#############################################################
# Proxy-only subnet (for Regional Internal HTTP(S) LB / PSC)
#############################################################
resource "google_compute_subnetwork" "proxy_only" {
  count         = var.enable_regional_managed_proxy ? 1 : 0
  project       = var.project_id
  region        = var.region
  name          = "${var.vpc_name}-proxy-only"
  ip_cidr_range = var.proxy_only_cidr               # e.g., "10.0.1.0/24"
  network       = google_compute_network.vpc.id
  purpose       = "REGIONAL_MANAGED_PROXY"
  role          = "ACTIVE"
  stack_type    = "IPV4_ONLY"
}

############################
# Cloud Router + Cloud NAT
############################
resource "google_compute_router" "r" {
  count   = var.enable_nat ? 1 : 0
  project = var.project_id
  region  = var.region
  name    = "${var.vpc_name}-router"
  network = google_compute_network.vpc.name
  # labels = var.labels
}

resource "google_compute_router_nat" "nat" {
  count                  = var.enable_nat ? 1 : 0
  project                = var.project_id
  region                 = var.region
  name                   = "${var.vpc_name}-nat"
  router                 = google_compute_router.r[0].name
  nat_ip_allocate_option = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"

  log_config {
    enable = var.nat_logging != "NONE"
    filter = var.nat_logging            # "ERRORS_ONLY" | "TRANSLATIONS_ONLY" | "ALL" | "NONE"
  }
}

####################
# Firewall rules
####################

# Tight SSH
resource "google_compute_firewall" "allow_ssh" {
  name    = "${var.vpc_name}-allow-ssh"
  network = google_compute_network.vpc.name
  project = var.project_id

  direction     = "INGRESS"
  priority      = 1000
  source_ranges = [var.allowed_cidr]

  target_tags = var.target_tags # ["test-server1"] or similar

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
}

# Optional ICMP from trusted range
resource "google_compute_firewall" "allow_icmp" {
  name    = "${var.vpc_name}-allow-icmp"
  network = google_compute_network.vpc.name
  project = var.project_id

  direction     = "INGRESS"
  priority      = 1000
  source_ranges = [var.allowed_cidr]

  allow {
    protocol = "icmp"
  }
}

# HTTP/HTTPS (only if you truly need them)
resource "google_compute_firewall" "allow_http" {
  count   = var.enable_http ? 1 : 0
  name    = "${var.vpc_name}-allow-http"
  network = google_compute_network.vpc.name
  project = var.project_id

  direction     = "INGRESS"
  priority      = 1000
  source_ranges = [var.allowed_cidr]
  target_tags   = var.target_tags

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }
}

resource "google_compute_firewall" "allow_https" {
  count   = var.enable_https ? 1 : 0
  name    = "${var.vpc_name}-allow-https"
  network = google_compute_network.vpc.name
  project = var.project_id

  direction     = "INGRESS"
  priority      = 1000
  source_ranges = [var.allowed_cidr]
  target_tags   = var.target_tags

  allow {
    protocol = "tcp"
    ports    = ["443"]
  }
}

# Intra-VPC (limit to your subnets, not 0.0.0.0/0)
resource "google_compute_firewall" "allow_internal" {
  name    = "${var.vpc_name}-allow-internal"
  network = google_compute_network.vpc.name
  project = var.project_id

  direction     = "INGRESS"
  priority      = 65534
  source_ranges = values(var.subnet_cidrs)   # all the CIDRs you defined

  allow { 
    protocol = "tcp"
    ports = ["0-65535"] 
  }

  allow { 
    protocol = "udp"
    ports = ["0-65535"] 
  }
  allow { 
    protocol = "icmp" 
  }
}
