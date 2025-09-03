variable "project_id" { type = string }
variable "network_name" { type = string }
variable "subnets" {
  type = list(object({
    name   = string
    cidr   = string
    region = string
  }))
}