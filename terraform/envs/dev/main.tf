# terraform {
#   backend "local" {}  # fully configured at init time from CI via a generated backend.hcl
# }
# provider "google" {
#   project = var.project_id
#   region  = var.region
#   zone    = var.zone
# }

# module "project" {
#   source          = "../../modules/projects"
#   project_name    = var.project_name
#   project_id      = var.project_id
#   billing_account = var.billing_account
#   org_id          = var.org_id
#   labels          = var.labels
#   enable_apis     = var.enable_apis
# }

module "networking" {
  source       = "../../modules/networking"
  project_id   = var.project_id
  vpc_name     = var.vpc_name
  region       = var.region
  network_name = var.vpc_name
  subnets      = var.subnets
  subnet_cidrs = var.subnet_cidrs
}

module "iam" {
  source     = "../../modules/iam"
  project_id = var.project_id
  bindings = [
    { role = "roles/storage.admin", member = "user:schhin@gmail.com" },
    { role = "roles/viewer", member = "user:schhin@gmail.com" }
  ]
}

module "storage" {
  source     = "../../modules/storage"
  project_id = var.project_id
  buckets    = var.storage_buckets
}

module "compute" {
  source     = "../../modules/compute"
  e2_name    = var.e2_name
  zone       = var.zone
  project_id = var.project_id
  vpc_name   = var.vpc_name
  # subnetwork            = var.subnetwork
  machine_type = var.machine_type
  boot_image   = var.boot_image
  # service_account_email = null
  disk_size_gb = var.disk_size_gb
  disk_type    = var.disk_type

  subnetwork = module.networking.subnet_self_links["primary"]
  # service_account_scopes = var.scopes
  tags = ["http-server", "https-server"]

}

