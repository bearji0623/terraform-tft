module "vpc" {
  source = "./vpc"
}

module "security_groups" {
  source  = "./sg"
  vpc_id  = module.vpc.vpc_id
  web_ip  = module.ec2.web_ip
  web1_ip = module.ec2.web1_ip  
}

module "ec2" {
  source = "./ec2"
  public_subnets         = module.vpc.public_subnets
  private_subnets        = module.vpc.private_subnets
  bastion_sg_id          = module.security_groups.bastion_sg_id
  web_sg_id              = module.security_groups.web_sg_id
  was_sg_id              = module.security_groups.was_sg_id
  nlb_dns_name           = module.nlb.nlb_dns_name  
}

module "rds" {
  source                = "./rds"
  vpc_id                 = module.vpc.vpc_id
  private_subnets        = module.vpc.private_subnets
  rds_sg_id              = module.security_groups.rds_sg_id 
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
  cloudfront_distribution_arn   = module.cdn.cloudfront_distribution_arn
}

module "route53" {
  source                                   = "./r53"
  route53_zone_id                          = "Z0668592GCRH4LPCX73B"
  domain_name                              = "94102108.btiucloud.com"
  alb_domain_name                          = module.alb.alb_dns_name
  alb_hosted_zone_id                       = module.alb.alb_zone_id
}

module "acm" {
  source          = "./acm"
  providers       = {
    aws.virginia = aws.virginia
  }
  domain_name     = "94102108.btiucloud.com"
  route53_zone_id = var.route53_zone_id
}

module "cdn" {
  source                      = "./cf"
  aliases                     = ["94102108.btiucloud.com"]
  acm_certificate_arn         = module.acm.acm_certificate_arn_virginia
  default_origin_domain_name  = "94102108-tft-s3.s3.ap-northeast-2.amazonaws.com"
  s3_origin_domain_name       = module.s3.web_bucket_domain_name
  alb_dns_name                = module.alb.alb_dns_name
  web_acl_id                  = module.waf.cloudfront_web_acl_arn
}

module "waf" {
  source = "./waf"
  providers = {
    aws = aws.virginia
  }
}

data "aws_acm_certificate" "acm" {
  domain   = "*.btiucloud.com"  # ACM 인증서에 연결된 도메인 이름
  most_recent = true  # 최신의 인증서를 선택
}

##########################

module "dev" {
  source = "./iam/dev"
}

module "prod" {
  source = "./iam/prod"
}