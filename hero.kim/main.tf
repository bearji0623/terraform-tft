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

module "s3" {
  source                     = "./s3"
  bucket_web                 = "bucket-web-trio"
  cloudfront_distribution_arn = module.cdn.cloudfront_distribution_arn
}