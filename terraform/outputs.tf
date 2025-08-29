output "project_id" {
  value       = google_project.project.project_id
  description = "Created GCP project ID"
}

output "vpc_self_link" {
  value       = google_compute_network.vpc.self_link
  description = "VPC self link"
}

output "subnet_urls" {
  value       = { for k, s in google_compute_subnetwork.subnets : k => s.self_link }
  description = "Subnets by region-name"
}

output "regions_with_nat" {
  value       = keys(google_compute_router_nat.nat)
  description = "Regions where NAT is configured"
}

output "workload_sa_email" {
  value       = google_service_account.workload.email
  description = "Workload service account email"
}

output "bucket_name" {
  value       = google_storage_bucket.bucket.name
  description = "Secure storage bucket"
}
