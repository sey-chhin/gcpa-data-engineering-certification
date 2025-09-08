terraform {
  required_version = ">= 1.5.0"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.30"
    }
    google-beta = {
      source  = "hashicorp/google-beta"
      version = "~> 5.30"
    }
  }
}

provider "google" {
  # Intentionally not setting project here; we set project on each resource.
  region = var.region
}

provider "google-beta" {
  region = var.region
}

# --------------------
# Project & APIs
# --------------------
resource "google_project" "project" {
  name                = var.project_name
  project_id          = var.project_id
  billing_account     = var.billing_account
  auto_create_network = false
  labels              = var.labels

  # Supply exactly one of org_id or folder_id (folder implies org).
  org_id    = var.org_id != "" ? var.org_id : null
  folder_id = var.folder_id != "" ? var.folder_id : null
}

resource "google_project_service" "apis" {
  for_each           = toset(var.enable_apis)
  project            = google_project.project.project_id
  service            = each.key
  disable_on_destroy = false
}

# --------------------
# Networking: VPC, Subnets, Router, NAT, Firewall
# --------------------
resource "google_compute_network" "vpc" {
  name                            = var.vpc_name
  project                         = google_project.project.project_id
  auto_create_subnetworks         = false
  routing_mode                    = "GLOBAL"
  delete_default_routes_on_create = false
}

# Subnets with Flow Logs and Private Google Access
resource "google_compute_subnetwork" "subnets" {
  for_each                 = { for s in var.subnets : "${s.region}-${s.name}" => s }
  name                     = each.value.name
  project                  = google_project.project.project_id
  region                   = each.value.region
  network                  = google_compute_network.vpc.self_link
  ip_cidr_range            = each.value.ip_cidr_range
  private_ip_google_access = lookup(each.value, "private_google_access", true)
  purpose                  = "PRIVATE"
  role                     = "ACTIVE"

  dynamic "log_config" {
    for_each = lookup(each.value, "flow_logs", true) ? [1] : []
    content {
      aggregation_interval = lookup(each.value, "aggregation_interval", "INTERVAL_5_MIN")
      flow_sampling        = lookup(each.value, "flow_sampling", 0.5)
      metadata             = "INCLUDE_ALL_METADATA"
    }
  }
}

# Per-region Cloud Router
locals {
  subnet_regions = toset([for s in var.subnets : s.region])
}

resource "google_compute_router" "router" {
  for_each = local.subnet_regions
  name     = "cr-${each.key}"
  project  = google_project.project.project_id
  region   = each.key
  network  = google_compute_network.vpc.self_link
}

# Cloud NAT for egress-only internet access
resource "google_compute_router_nat" "nat" {
  for_each                            = local.subnet_regions
  name                                = "nat-${each.key}"
  project                             = google_project.project.project_id
  router                              = google_compute_router.router[each.key].name
  region                              = each.key
  nat_ip_allocate_option              = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat  = "ALL_SUBNETWORKS_ALL_IP_RANGES"
  enable_endpoint_independent_mapping = true
  udp_idle_timeout_sec                = 30
  tcp_established_idle_timeout_sec    = 1200
  tcp_transitory_idle_timeout_sec     = 30
  icmp_idle_timeout_sec               = 30
  log_config {
    enable = true
    filter = "ALL"
  }
}

# Explicit egress allow (default behavior is allow egress, deny ingress)
resource "google_compute_firewall" "egress_allow_all" {
  name      = "egress-allow-all"
  project   = google_project.project.project_id
  network   = google_compute_network.vpc.name
  direction = "EGRESS"
  priority  = 65534

  allow {
    protocol = "all"
  }
  destination_ranges = ["0.0.0.0/0"]
}

# Optional: allow SSH via IAP only (attach tag 'ssh-via-iap' to instances that should allow SSH)
resource "google_compute_firewall" "allow_iap_ssh" {
  count     = var.enable_iap_ssh ? 1 : 0
  name      = "ingress-allow-iap-ssh"
  project   = google_project.project.project_id
  network   = google_compute_network.vpc.name
  direction = "INGRESS"
  priority  = 1000

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
  source_ranges = ["35.235.240.0/20"]
  target_tags   = ["ssh-via-iap"]
}

# --------------------
# Identity: Service Account & IAM
# --------------------


# Expand role->members map into (role, member) pairs
locals {
  project_iam_pairs = flatten([
    for role, members in var.project_iam : [
      for m in members : {
        role   = role
        member = m
      }
    ]
  ])
}

resource "google_project_iam_member" "project" {
  for_each = { for p in local.project_iam_pairs : "${p.role}:${p.member}" => p }
  project  = google_project.project.project_id
  role     = each.value.role
  member   = each.value.member
}

# --------------------
# Storage: Secure bucket
# --------------------
resource "google_storage_bucket" "bucket" {
  name                        = var.bucket_name
  project                     = google_project.project.project_id
  location                    = var.bucket_location
  uniform_bucket_level_access = true
  force_destroy               = false

  versioning {
    enabled = true
  }

  dynamic "retention_policy" {
    for_each = var.bucket_retention_days > 0 ? [1] : []
    content {
      retention_period = var.bucket_retention_days * 24 * 60 * 60
      is_locked        = false
    }
  }

  labels = merge(var.labels, { purpose = "secure-storage" })
}
