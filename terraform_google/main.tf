resource "google_project_service" "api_gke_enable" {
  project = var.ops_project
    service = "container.googleapis.com"

  timeouts {
    create = "30m"
    update = "40m"
  }

  disable_dependent_services = true
}

module "gke_ghack_cluster" {
  source = "./modules/gke"
  ops_project = var.ops_project
  ops_region =  var.ops_region
  ops_network = "${var.prefix}-vpc"
  ops_subnetwork = "${var.prefix}-subnet"

  prefix = var.prefix
  depends_on = [ 
    google_project_service.api_gke_enable,
    module.network 
    ]
}

module "projects_teams" {
  source = "./modules/team-sa"
  teams = var.teams
  prefix = var.prefix
  ops_project = var.ops_project
}
module "network" {
  source = "./modules/network"
  vpc_network_name = "${var.prefix}-vpc"
  ops_project = var.ops_project
  vpc_network_description = var.vpc_network_description
  vpc_network_routing_mode = var.vpc_network_routing_mode
  subnet_name = "${var.prefix}-subnet"
  subnet_range = var.subnet_range
  compute_region = var.ops_region
  subnet_description = var.subnet_description
  firewall_rule_egress_deny_all_name = "egress-deny-all"
  firewall_rule_egress_deny_all_description = "Egress deny all rule"
  #firewall_rule_egress_allow_restricted_name ="${var.prefix}-egress-allow"
  
}