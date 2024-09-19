module "vpc" {
  source = "./vpc"
}

module "security_groups" {
  source  = "./sg"
  vpc_id  = module.vpc.vpc_id
  was_ip  = module.ec2.was_ip
  was1_ip = module.ec2.was1_ip  
}

module "ec2" {
  source = "./ec2"
  public_subnets         = module.vpc.public_subnets
  private_subnets        = module.vpc.private_subnets
  bastion_sg_id          = module.security_groups.bastion_sg_id
  web_sg_id              = module.security_groups.web_sg_id
}

module "alb" {
  source                 = "./alb"
  vpc_id                 = module.vpc.vpc_id
  public_subnets         = module.vpc.public_subnets
  alb_sg_id              = module.security_groups.alb_sg_id
  target_instance_ids    = [module.ec2.ec2_instance1_id, module.ec2.ec2_instance2_id]
  bucket_id              = module.s3.bucket_id
}

module "nlb" {
  source                 = "./nlb"
  vpc_id                 = module.vpc.vpc_id
  private_subnets        = slice(module.vpc.private_subnets, 0, 2)
  target_instance_ids    = [module.ec2.ec2_instance3_id, module.ec2.ec2_instance4_id]
}

module "s3" {
  source                     = "./s3"
}

module "route53" {
  source                                   = "./r53"
  route53_zone_id                          = "Z0668592GCRH4LPCX73B"
  domain_name                              = "94102108.btiucloud.com"
  alb_domain_name                          = module.alb.alb_dns_name
  alb_hosted_zone_id                       = module.alb.alb_zone_id
}

module "dev" {
  source = "./iam/dev"
}

module "prod" {
  source = "./iam/prod"
}