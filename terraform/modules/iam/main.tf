locals {
  # Accept both:
  #   - { role = "...", member = "type:principal" }
  #   - { role = "...", members = ["type:principal", ...] }
  bindings_flat = flatten([
    for b in var.bindings :
      (try(b.members, null) != null
        ? [for m in b.members : { role = b.role, member = m }]
        : [{ role = b.role, member = b.member }]
      )
  ])
}

resource "google_project_iam_member" "bindings" {
  for_each = { for b in local.bindings_flat : "${b.role}-${b.member}" => b }
  project  = var.project_id
  role     = each.value.role
  member   = each.value.member
}
