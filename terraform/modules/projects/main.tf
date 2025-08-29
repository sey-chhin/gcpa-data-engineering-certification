resource "google_project" "project" {
  name                = var.project_name
  project_id          = var.project_id
  billing_account     = var.billing_account
  org_id              = var.org_id
  auto_create_network = false
  labels              = var.labels
}

resource "google_project_service" "services" {
  for_each           = toset(var.enable_apis)
  project            = google_project.project.project_id
  service            = each.value
  disable_on_destroy = false
}

output "id" {
  value = google_project.project.project_id
}