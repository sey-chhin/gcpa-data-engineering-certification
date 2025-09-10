output "vpc_id" {
  description = "Resource ID of the VPC network"
  value       = google_compute_network.vpc.id
}

output "vpc_self_link" {
  description = "Self link of the VPC network"
  value       = google_compute_network.vpc.self_link
}

output "subnet_ids" {
  description = "Map of subnet name => resource ID"
  value       = { for k, s in google_compute_subnetwork.subs : k => s.id }
}

output "subnet_self_links" {
  description = "Map of subnet name => self link"
  value       = { for k, s in google_compute_subnetwork.subs : k => s.self_link }
}

# If you create a router/NAT, you can also expose their names (IDs are server-generated):
# output "router_name" { value = one(google_compute_router.r[*].name) }
# output "nat_name"    { value = one(google_compute_router_nat.nat[*].name) }

