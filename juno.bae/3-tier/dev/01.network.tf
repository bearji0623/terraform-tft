module "network" {
  source                = "../modules/network"
  
  env                   = var.env
  project               = var.project
  
  vpc_cidr              = var.vpc_cidr        
  enable_dns_hostnames  = var.enable_dns_hostnames
  
  subnet                = var.subnet
  route_tables          = var.route_tables
  
  endpoint_service_name = var.endpoint_service_name
  endpoint_type         = var.endpoint_type
}