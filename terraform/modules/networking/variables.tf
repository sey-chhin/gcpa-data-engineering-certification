variable "project_id" {
  description = "The GCP project ID"
  type        = string
}

variable "network_name" {
  description = "The name of the network"
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

variable "labels" {
  description = "Labels applied to networking resources"
  type        = map(string)
  default = {
    owner   = "sey"
    ttl     = "24h"
    purpose = "lab"
  }
}

variable "nat_logging" {
  description = "Cloud NAT logging filter: NONE | ERRORS_ONLY | ALL"
  type        = string
  default     = "ERRORS_ONLY"
}

variable "subnet_cidrs" {
  description = "Map of subnet_name => CIDR (e.g., { primary = \"10.0.0.0/24\" })"
  type        = map(string)
}

variable "vpc_name" {
  description = "The name of the VPC network"
  type        = string
}

variable "region" {
  description = "The region to deploy resources"
  type        = string
}

variable "enable_nat" {
  description = "Enable Cloud NAT"
  type        = bool
  default     = false
}

variable "allowed_cidr" {
  description = "CIDR allowed to reach HTTP/HTTPS on the VM"
  type        = string
  default     = "0.0.0.0/0"
}