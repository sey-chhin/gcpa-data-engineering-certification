# backend.tf (local)
terraform {
  backend "local" {
    path = "state/terraform.tfstate"
    lock = true
  }
}