terraform {
  backend "gcs" {
    bucket = "pde-exam-bucket-1"
    prefix = "terraform/envs/dev"
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
  zone    = var.zone
}

module "project" {
  source          = "../../modules/projects"
  project_name    = var.project_name
  project_id      = var.project_id
  billing_account = var.billing_account
  org_id          = var.org_id
  labels          = var.labels
  enable_apis     = var.enable_apis
}

module "networking" {
  source       = "../../modules/networking"
  project_id   = module.project.id
  network_name = var.vpc_name
  subnets      = var.subnets
}

module "iam" {
  source          = "../../modules/iam"
  project_id      = module.project.id
  sa_id           = var.workload_sa_id
  sa_display_name = var.workload_sa_display_name
  bindings        = var.iam_bindings
}

module "storage" {
  source     = "../../modules/storage"
  project_id = module.project.id
  buckets    = var.storage_buckets
}

module "compute" {
  source        = "../../modules/compute"
  e2_name       = var.e2_name
  zone          = var.zone
  project_id    = var.project_id
  vpc_name      = var.vpc_name
  subnetwork    = var.subnetwork
  machine_type  = var.machine_type
  boot_image    = var.boot_image
  service_account_email = var.workload_sa_email
  disk_size_gb  = var.disk_size_gb
  disk_type     = var.disk_type
  tags          = var.tags
  # service_account_scopes = var.scopes
}