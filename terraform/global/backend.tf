terraform {
  backend "gcs" {
    bucket = "pde-exam-bucket-1"
    prefix = "terraform/state"
  }
}