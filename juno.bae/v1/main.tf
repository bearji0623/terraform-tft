### VPC 모듈 ###
module "vpc" {
  source = "./module/vpc"
}


### EC2 모듈 ###
module "ec2" {
  source = "./module/ec2"
    
    # VPC 모듈 네트워크 정보
    vpc_id = module.vpc.vpc_id
    pub_sub_id = module.vpc.pub_sub_id
    pri_sub_web_id = module.vpc.pri_sub_web_id
    pri_sub_was_id = module.vpc.pri_sub_was_id
    pri_sub_db_id = module.vpc.pri_sub_db_id
    
    # ACM 전달
    acm_certificate_arn = data.aws_acm_certificate.wildcard_btiucloud_com.arn
}


### RDS 모듈 ###
module "rds" {
  source = "./module/rds"
  
  # VPC 모듈 네트워크 정보
  vpc_id = module.vpc.vpc_id
  pri_sub_db_id = module.vpc.pri_sub_db_id
}

### S3 모듈 ###
module "cdn" {
  source = "./module/cdn"
}


### Security 모듈 ###
module "security" {
  source = "./module/security"
  
  alb_pub_id = module.ec2.alb_web_id
}


### Route53 가져오기 ###
data "aws_route53_zone" "btiucloud_com" {
  name = "btiucloud.com"
}


### Route 53 레코드 설정 ###
resource "aws_route53_record" "juno_btiucloud_com" {
  zone_id = data.aws_route53_zone.btiucloud_com.zone_id
  name    = "juno.btiucloud.com"
  type    = "A"
  
  alias {
    name    = module.ec2.alb_dns_name_id
    zone_id = module.ec2.alb_zone_id
    evaluate_target_health = true
  }
}


### ACM 가져오기 ###
data "aws_acm_certificate" "wildcard_btiucloud_com" {
  domain   = "*.btiucloud.com"
}