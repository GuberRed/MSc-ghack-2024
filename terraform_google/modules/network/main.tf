module "vpc" {
  source = "./networkmodules/vpc"

  network_name = "${var.prefix}-vpc"
  project_id   = var.ops_project
  description  = var.vpc_network_description
  routing_mode = var.vpc_network_routing_mode

}

module "subnet" {
  source = "./networkmodules/subnets"

  subnet_name           = "${var.prefix}-subnet"
  subnet_ip             = var.subnet_range
  subnet_region         = var.compute_region
  subnet_private_access = true
  network_name          = module.vpc.network_name
  project_id            = var.ops_project
  description           = var.subnet_description
}
/*
module "egress_deny_all" {
  source = "./networkmodules/firewall-rules"

  name         = var.firewall_rule_egress_deny_all_name
  description  = var.firewall_rule_egress_deny_all_description
  direction    = "EGRESS"
  network_name = module.vpc.network_name
  project_id   = var.ops_project
  ranges       = ["0.0.0.0/0"]
  priority = 3000
  deny = [{
    protocol = "all"
  }]
  # allow = [{
  #   protocol = "icmp"
  # }]
}
*/