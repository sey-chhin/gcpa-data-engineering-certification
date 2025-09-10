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
