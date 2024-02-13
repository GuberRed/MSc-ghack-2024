output "network" {
  value       = module.vpc.network
  description = "The VPC resource being created"
}

output "network_name" {
  value       = module.vpc.network_name
  description = "The name of the VPC being created"
}

output "network_id" {
  value       = module.vpc.network_id
  description = "The ID of the VPC being created"
}

output "network_self_link" {
  value       = module.vpc.network_self_link
  description = "The URI of the VPC being created"
}

output "subnet_id" {
  value       = module.subnet.subnet_id
  description = "An identifier for the resource with format projects/{{project}}/regions/{{region}}/subnetworks/{{name}}"
}

output "subnet_name" {
  value       = module.subnet.subnet_name
  description = "The subnet name."
}

output "subnet_self_link" {
  value       = module.subnet.self_link
  description = "The URI of the created resource."
}