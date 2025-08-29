variable "project_id" { type = string }
variable "buckets" {
  type = list(object({
    name     = string
    location = string
  }))
}