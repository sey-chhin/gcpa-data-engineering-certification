provider "google" {
  region  = var.default_region
  
}

variable "default_region" {
  description = "Default GCP region"
  type        = string
  default     = "us-east4"
}