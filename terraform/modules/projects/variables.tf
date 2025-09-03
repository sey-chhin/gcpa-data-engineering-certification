variable "project_name" { type = string }
variable "project_id" { type = string }
variable "billing_account" { type = string }
variable "org_id" { type = string }
variable "labels" { type = map(string) }
variable "enable_apis" { type = list(string) }