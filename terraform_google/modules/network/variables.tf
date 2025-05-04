variable "prefix" { type = string }
variable "ops_project" { type = string }
variable "compute_region" { type = string }

#NETWORK VARS

variable "vpc_network_description" {
  type        = string
  default     = "VPC Network for Infra challange for ghack2024"
  description = "VPC network description"
}

variable "vpc_network_routing_mode" {
  type        = string
  default     = "REGIONAL"
  description = "VPC network routing mode"
}

variable "subnet_description" {
  type        = string
  default     = "subenet description"
  description = "Subnet description"
}

variable "subnet_range" {
  type        = string
  default     = "10.20.30.0/24"
  description = "Subnet range"
}
