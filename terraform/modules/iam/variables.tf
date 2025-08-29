variable "project_id" { type = string }
variable "sa_id" { type = string }
variable "sa_display_name" { type = string }
variable "bindings" {
  type = list(object({
    role   = string
    member = string
  }))
}