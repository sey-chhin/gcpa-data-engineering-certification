variable "project_id" { type = string }
variable "network_name" { type = string }
variable "subnets" {
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

# Add your variable declarations here

variable "subnet_cidrs" {
  type        = map(string)
  description = "Map of subnet_name => CIDR (e.g., { primary = \"10.10.0.0/24\" })"
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