resource "google_compute_network" "vpc" {
  project                 = var.project_id
  name                    = var.vpc_name
  auto_create_subnetworks = false
  //labels                  = var.labels
}

resource "google_compute_subnetwork" "subs" {
  for_each                 = var.subnet_cidrs
  project                  = var.project_id
  region                   = var.region
  name                     = "${var.vpc_name}-${each.key}"
  ip_cidr_range            = each.value
  network                  = google_compute_network.vpc.id
  private_ip_google_access = true
  stack_type               = "IPV4_ONLY"
  purpose                  = "PRIVATE"
  //labels                           = var.labels
}

resource "google_compute_router" "r" {
  count   = var.enable_nat ? 1 : 0
  project = var.project_id
  region  = var.region
  name    = "${var.vpc_name}-router"
  network = google_compute_network.vpc.name
  //labels  = var.labels
}

resource "google_compute_router_nat" "nat" {
  count                  = var.enable_nat ? 1 : 0
  project                = var.project_id
  region                 = var.region
  name                   = "${var.vpc_name}-nat"
  router                 = google_compute_router.r[0].name
  nat_ip_allocate_option = "AUTO_ONLY"
  # Ensure no static addresses are reserved; keep NAT cheap/ephemeral.
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
  log_config {
    enable = var.nat_logging != "NONE"
    filter = var.nat_logging
  }
}

resource "google_compute_firewall" "allow_http" {
  name    = "${var.vpc_name}-allow-http"
  network = google_compute_network.vpc.name
  project = var.project_id

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  direction   = "INGRESS"
  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["http-server"]
}

resource "google_compute_firewall" "allow_https" {
  name    = "${var.vpc_name}-allow-https"
  network = google_compute_network.vpc.name
  project = var.project_id

  allow {
    protocol = "tcp"
    ports    = ["443"]
  }

  direction   = "INGRESS"
  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["https-server"]
}

resource "google_compute_firewall" "allow_ssh" {
  name    = "${var.vpc_name}-allow-ssh"
  network = google_compute_network.vpc.name
  project = var.project_id

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  direction   = "INGRESS"
  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["allow-ssh"]
}