

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
# output "workload_service_account_email" {
#   description = "Email address of the workload service account"
#   value       = "${var.workload_sa_id}@${var.project_id}.iam.gserviceaccount.com"
# }

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
  value = module.compute.instance_name
}

output "external_ip" {
  value = module.compute.external_ip
}