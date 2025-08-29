resource "google_service_account" "workload" {
  project      = var.project_id
  account_id   = var.sa_id
  display_name = var.sa_display_name
}

resource "google_project_iam_member" "bindings" {
  for_each = { for b in var.bindings : "${b.role}-${b.member}" => b }
  project  = var.project_id
  role     = each.value.role
  member   = each.value.member
}