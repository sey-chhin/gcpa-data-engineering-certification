resource "google_compute_network" "vpc" {
  name                    = var.network_name
  project                 = var.project_id
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "subnet" {
  for_each                 = { for s in var.subnets : s.name => s }
  name                     = each.value.name
  project                  = var.project_id
  ip_cidr_range            = each.value.cidr
  region                   = each.value.region
  network                  = google_compute_network.vpc.id
  private_ip_google_access = true
}

resource "google_compute_firewall" "egress_allow_all" {
  name      = "egress-allow-all"
  project   = var.project_id
  network   = google_compute_network.vpc.name
  direction = "EGRESS"
  priority  = 65534
  allow { protocol = "all" }
  destination_ranges = ["0.0.0.0/0"]
}

output "vpc_id" {
  value = google_compute_network.vpc.id
}