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