variable "project_name" {}
variable "project_id" {}
variable "billing_account" {}
variable "org_id" {}
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
variable "workload_sa_id" {}
variable "workload_sa_display_name" {}
variable "iam_bindings" {
  type = list(object({
    role   = string
    member = string
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

variable "boot_image" { type = map(string) }

variable "disk_size_gb" { type = map(number) }

variable "disk_type" { type = map(string) }


variable "tags" {
  type        = list(string)
  default     = []
}

variable "e2_name" { type = string }

variable "zone" { type = string }

variable "subnetwork" { type = string}

variable "workload_sa_email" { type = string }

# variable "backend_bucket" {
#   type        = string
# }
variable "machine_type" { type = string }