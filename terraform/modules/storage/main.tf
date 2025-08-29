resource "google_storage_bucket" "bucket" {
  for_each                    = { for b in var.buckets : b.name => b }
  name                        = each.value.name
  project                     = var.project_id
  location                    = each.value.location
  uniform_bucket_level_access = true

  versioning { enabled = true }
}