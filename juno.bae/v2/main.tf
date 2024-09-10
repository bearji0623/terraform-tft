### VPC 모듈 ###
module "vpc" {
  source = "./modules/vpc"
  env = var.env
  project = var.project
}