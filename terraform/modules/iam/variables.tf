variable "project_id" { type = string }


variable "bindings" {
  description = "Either list of { role, member } or list of { role, members=[...] }"
  type = list(object({
    role    = string
    member  = optional(string)
    members = optional(list(string))
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
