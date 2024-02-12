variable "vpc_network_name" {
  description = "The name of the VPC network."
}

variable "ops_project" {
  description = "The project ID where resources will be created."
}

#network
variable "vpc_network_description" {
    default = "vpc description"
  description = "The description of the VPC network."
}

variable "vpc_network_routing_mode" {
    default = "GLOBAL"
  description = "The routing mode of the VPC network."
}

variable "subnet_name" {
  description = "The name of the subnet."
}

variable "subnet_range" {
    default = "10.20.30.0/24"
  description = "The IP range of the subnet."
}

variable "compute_region" {
  description = "The region where the subnet will be created."
}

variable "subnet_description" {
  description = "The description of the subnet."
}

variable "firewall_rule_egress_deny_all_name" {
  description = "The name of the egress deny all firewall rule."
}

variable "firewall_rule_egress_deny_all_description" {
  description = "The description of the egress deny all firewall rule."
}
