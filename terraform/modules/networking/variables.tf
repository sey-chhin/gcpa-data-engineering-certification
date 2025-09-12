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
  description = "Cloud NAT logging filter: NONE | ERRORS_ONLY | TRANSLATIONS_ONLY | ALL"
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
variable "project_id" { type = string }
variable "vpc_name"    { type = string }
variable "region"      { type = string }

# Map of subnet name -> CIDR, e.g. { primary = "10.150.0.0/20" }
variable "subnet_cidrs" {
  type = map(string)
}

variable "allowed_cidr" {
  description = "Trusted source CIDR for admin ingress (SSH/ICMP/HTTP/HTTPS if enabled)"
  type        = string
}

variable "target_tags" {
  description = "Network tags applied to instances that should receive the ingress rules"
  type        = list(string)
  default     = []
}

variable "enable_nat" {
  type    = bool
  default = false
}
# variable "nat_logging" { type = string default = "ERRORS_ONLY" } # NONE | ERRORS_ONLY | TRANSLATIONS_ONLY | ALL

variable "enable_regional_managed_proxy" {
  description = "Create a REGIONAL_MANAGED_PROXY subnet (needed for Regional Internal HTTP(S) LB / PSC)"
  type        = bool
  default     = false
}

variable "proxy_only_cidr" {
  description = "CIDR for proxy-only subnet (non-routable to VMs)"
  type        = string
  default     = "10.0.1.0/24"
}

variable "enable_http" {
  type    = bool
  default = false
}
variable "enable_https" {
  type    = bool
  default = false
}