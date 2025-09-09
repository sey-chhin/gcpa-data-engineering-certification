variable "project_name" {
  description = "Name of the project"
  type        = string
}

variable "project_id" {
  description = "ID of the project"
  type        = string
}

variable "billing_account" {
  description = "Billing account ID"
  type        = string
}

variable "org_id" {
  description = "Organization ID"
  type        = string
}

variable "labels" {
  description = "Labels to apply to resources"
  type        = map(string)
}

variable "enable_apis" {
  description = "List of APIs to enable"
  type        = list(string)
}

variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
}

variable "subnets" {
  description = "List of subnet configurations"
  type = list(object({
    name   = string
    cidr   = string
    region = string
  }))
}

variable "iam_bindings" {
  description = "IAM bindings for the project"
  type = list(object({
    role   = string
    member = string
  }))
}

variable "storage_buckets" {
  description = "List of storage buckets"
  type = list(object({
    name     = string
    location = string
  }))
}

variable "region" {
  description = "Region for resources"
  type        = string
}

variable "boot_image" {
  description = "Boot image for VM"
  type        = string
}

variable "disk_size_gb" {
  description = "Disk size in GB"
  type        = number
}

variable "disk_type" {
  description = "Type of disk"
  type        = string
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = list(string)
  default     = []
}

variable "e2_name" {
  description = "Name of the E2 instance"
  type        = string
}

variable "zone" {
  description = "Zone for resources"
  type        = string
}

variable "subnetwork" {
  description = "Subnetwork for resources"
  type        = string
}

variable "workload_sa_email" {
  description = "Service account email for workload"
  type        = string
}

variable "machine_type" {
  description = "Machine type for VM"
  type        = string
}

variable "subnet_cidrs" {
  description = "List of CIDR blocks for the subnets"
  type        = map(string)
}

variable "allowed_cidr" {
  description = "CIDR allowed to reach HTTP/HTTPS on the VM"
  type        = string
  default     = "0.0.0.0/0"
}