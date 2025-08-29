########################################
# Project outputs
########################################
output "project_id" {
  description = "The ID of the GCP project"
  value       = module.project.id
}

########################################
# Networking outputs
########################################
output "vpc_id" {
  description = "VPC network ID"
  value       = module.networking.vpc_id
}

output "subnet_ids" {
  description = "List of subnet IDs created in this environment"
  value       = [for s in var.subnets : "${module.networking.vpc_id}/subnetworks/${s.name}"]
}

########################################
# IAM outputs
########################################
output "workload_service_account_email" {
  description = "Email address of the workload service account"
  value       = "${var.workload_sa_id}@${module.project.id}.iam.gserviceaccount.com"
}

########################################
# Storage outputs
########################################
output "storage_bucket_names" {
  description = "List of storage bucket names"
  value       = [for b in var.storage_buckets : b.name]
}

########################################
# Compute outputs
########################################
output "instance_name" {
  value       = google_compute_instance.e2_vm.name
  description = "Name of the created VM instance"
}

output "instance_self_link" {
  value       = google_compute_instance.e2_vm.self_link
  description = "Self-link of the VM instance"
}

output "instance_external_ip" {
  value       = google_compute_instance.e2_vm.network_interface[0].access_config[0].nat_ip
  description = "External IP address"
}
