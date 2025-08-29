variable "e2_name" {}
variable "machine_type" {}
variable "zone" {}
variable "project_id" {}
variable "boot_image" {}
variable "disk_size_gb" {
  default = 20
}
variable "disk_type" {
  default = "pd-balanced"
}
variable "vpc_name" {}
variable "subnetwork" {}
variable "service_account_email" {}
variable "scopes" {
  type    = list(string)
  default = ["https://www.googleapis.com/auth/cloud-platform"]
}
variable "tags" {
  type    = list(string)
  default = []
}
