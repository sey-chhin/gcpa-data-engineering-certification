variable "e2_name" {}
variable "machine_type" {}
variable "zone" {}
variable "project_id" {}
variable "boot_image" {}
variable "disk_size_gb" {
  default = 10
  type = number
}
variable "disk_type" {
  type = string 
  default = "Balanced persistent disk"
}
variable "vpc_name" {}
variable "subnetwork" {}
variable "service_account_email" {}
variable "scopes" {
  type = list(string)
  default = ["https://www.googleapis.com/auth/cloud-platform"]
}
variable "tags" {
  type = list(string)
  default = []
}
