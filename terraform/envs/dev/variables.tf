### used for creating projects only 
# variable "project_name" {}
# variable "billing_account" {}
# variable "org_id" {}

variable "project_id" {}
variable "labels" { type = map(string) }
variable "enable_apis" { type = list(string) }
variable "vpc_name" {}
variable "subnets" {
  type = list(object({
    name   = string
    cidr   = string
    region = string
  }))
}


variable "storage_buckets" {
  type = list(object({
    name     = string
    location = string
  }))
}
variable "region" {}

# variable "e2_name" {
#     type = list(object({
#     name     = string
#   }))
# }

# e2 machines


# variable "project_id" { type = map(string) }

variable "boot_image" { type = string }

variable "disk_size_gb" { type = number }

variable "disk_type" { type = string }


variable "tags" {
  type    = list(string)
  default = []
}

variable "e2_name" { type = string }

variable "zone" { type = string }

variable "subnetwork" { type = string }

variable "workload_sa_email" { type = string }

# variable "backend_bucket" {
#   type        = string
# }
variable "machine_type" { type = string }
# Add your variable declarations below

variable "subnet_cidrs" {
  description = "List of CIDR blocks for the subnets"
  type        = map(string)
}
# Add your variable declarations here

variable "allowed_cidr" {
  description = "CIDR allowed to reach HTTP/HTTPS on the VM"
  type        = string
  default     = "0.0.0.0/0"
}
