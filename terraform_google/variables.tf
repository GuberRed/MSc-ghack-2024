#GENERAL VARS
variable "credentials" {
  description = "Credentials for gcs SA impersonation"
}
variable "prefix" {
  type = string
  description = "prefix for all resources"
}
variable "terraform_service_account" {
  description = "terraform SA to deploy all resources"
  
}
variable "teams" {
  type = list(string)
  default = ["teama", "teamb", "zzzz"]
  description = "teamlist"
}
variable "ops_project" {
  type = string
  #default = "gcp-coe-msp-sandbox"
}

variable "ops_region" {
  type = string
  #default = "europe-west1"
}


# #NETWORK VARS
# variable "vpc_network_name" {
#   type = string
#   default = "${var.prefix}-vpc"
#   description = "VPC Network name for Infra challange for ghack2024"
# }

# variable "vpc_network_description" {
#   type = string
#   default = "VPC Network for Infra challange for ghack2024"
#   description = "VPC network description"
# }

# variable "vpc_network_routing_mode" {
#   type = string
#   default = "REGIONAL"
#   description = "VPC network routing mode"
# }

# variable "subnet_name" {
#   type = string
#   default = "${var.prefix}-subnet"
#   description = "Subnet name"
# }

# variable "subnet_description" {
#   type = string
#   default = "Subnet for ${var.prefix}"
#   description = "Subnet description"
# }

# variable "subnet_range" {
#   type = string
#   default = "10.20.30.0/24"
#   description = "Subnet range"
# }

# variable "firewall_rule_egress_deny_all_name" {
#   type = string
#   default = "${var.prefix}-egress-deny-all"
#   description = "Firewall rule name for denying all egress"
# }

# variable "firewall_rule_egress_deny_all_description" {
#   type = string
#   default = "Deny all egress traffic"
#   description = "Firewall rule description for denying all egress"
# }

# variable "firewall_rule_egress_allow_restricted_name" {
#   type = string
#   default = "${var.prefix}-egress-allow-restricted"
#   description = "Firewall rule name for allowing restricted APIs access"
# }

# variable "firewall_rule_egress_allow_restricted_description" {
#   type = string
#   default = "Allow egress traffic only from restricted apis"
#   description = "Firewall rule description for allowing restricted APIs access"
# }