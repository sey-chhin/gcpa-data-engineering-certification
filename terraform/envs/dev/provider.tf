terraform {
  required_version = "~> 1.6"
  # required_providers {
  #   google = { source = "hashicorp/google", version = "~> 5.40" }
  #   google-beta = { source = "hashicorp/google-beta", version = "~> 5.40" }
}
# backend "gcs" {}
# }

provider "google" {
  project = var.project_id
  region  = var.region
  zone    = var.zone
}

