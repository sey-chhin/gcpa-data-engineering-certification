provider "google" {
  region  = var.default_region
  project = var.project_id
}

variable "default_region" {
  description = "Default GCP region"
  type        = string
  default     = "us-east4"
}

variable "project_id" {
  description = "GCP project ID"
  type        = string
}