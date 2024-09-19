module "vpc" {
  source = "./vpc"
}

module "security_groups" {
  source  = "./sg"
  vpc_id  = module.vpc.vpc_id
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

module "s3" {
  source                     = "./s3"
}

module "dev" {
  source = "./iam/dev"
}

module "prod" {
  source = "./iam/prod"
}