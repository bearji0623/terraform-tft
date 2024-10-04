### 공통 ###
project          = "JUNO"
env              = "DEV"

### VPC 설정 ###
vpc_cidr         = "10.0.0.0/16"
enable_dns_hostnames = true

### SUBNET 설정 ###
subnet = {
  public_subnet_a     = { cidr = "10.0.10.0/24", az = "ap-northeast-2a", name = "SBN-A-PUB", route_table = "public_rt" }
  public_subnet_c     = { cidr = "10.0.20.0/24", az = "ap-northeast-2c", name = "SBN-C-PUB", route_table = "public_rt" }
  web_subnet_a        = { cidr = "10.0.30.0/24", az = "ap-northeast-2a", name = "SBN-A-WEB", route_table = "web_rt" }
  web_subnet_c        = { cidr = "10.0.40.0/24", az = "ap-northeast-2c", name = "SBN-C-WEB", route_table = "web_rt" }
  was_subnet_a        = { cidr = "10.0.50.0/24", az = "ap-northeast-2a", name = "SBN-A-WAS", route_table = "was_rt" }
  was_subnet_c        = { cidr = "10.0.60.0/24", az = "ap-northeast-2c", name = "SBN-C-WAS", route_table = "was_rt" }
  db_subnet_a         = { cidr = "10.0.70.0/24", az = "ap-northeast-2a", name = "SBN-A-DB",  route_table = "db_rt" }
  db_subnet_c         = { cidr = "10.0.80.0/24", az = "ap-northeast-2c", name = "SBN-C-DB",  route_table = "db_rt" }
}

### 라우팅 테이블 설정 ###
route_tables = { 
  public_rt           = { name = "RTB-PUB", is_public = true }
  web_rt              = { name = "RTB-WEB", is_public = false }
  was_rt              = { name = "RTB-WAS", is_public = false }
  db_rt               = { name = "RTB-DB",  is_public = false }
}

### GW 엔드포인트 설정 ###
endpoint_service_name     = "com.amazonaws.ap-northeast-2.s3"
endpoint_type             = "Gateway"


### EC2 공통 설정 ###
ec2_common = {
  ami                   = "ami-07d737d4d8119ad79"
  ec2_type              = "t2.micro"
  key_name              = "94102047-2"
  root_volume_size      = 8
  root_volume_type      = "gp3"
  volume_encrypted      = true
  kms_key_id            = "arn:aws:kms:ap-northeast-2:637423403127:key/939c560c-8cde-41dc-b1dc-6bdf92c51e5a"
}

### EC2 Bastion 설정 ###
ec2_bastion = {
  enable_public_ip      = true                 # 퍼블릭 IP 할당 여부
  name                  = "EC2-AZ1-BASTION"    # 인스턴스 이름 태그
}

#### EC2 WEB 설정 ###
ec2_web = {
  "web1" = { name = "EC2-AZ1-WEB", enable_public_ip = false, ebs_volume_size = 50, ebs_volume_type = "gp3", device_name = "/dev/sdf", delete_on_termination = true }
  "web2" = { name = "EC2-AZ3-WEB", enable_public_ip = false, ebs_volume_size = 50, ebs_volume_type = "gp3", device_name = "/dev/sdf", delete_on_termination = true }
}


### 퍼블릭 WEB ALB 설정 ###
alb_web_pub = {
  alb_name           = "ALBWEB-PUB"
  enable_internal    = false                  # 퍼블릭
  load_balancer_type = "application"          # ALB 타입
}

### WEB ALB 타겟그룹 80 포트 ###
alb_web_target_80 = {
  tg_name                 = "ALB-WEB-TG-80"
  port                    = 80
  protocol                = "HTTP"
  target_type             = "instance"
  health_check_path       = "/"
  health_check_protocol   = "HTTP"
  health_check_interval   = 30
  health_check_timeout    = 5
  healthy_threshold       = 3
  unhealthy_threshold     = 3
}

### WEB ALB 리스너 ###
web_80_listner = {
  port                    = 80
  protocol                = "HTTP"
  type                    = "forward"
}


#### EC2 WAS 설정 ###
ec2_was = {
  "was1" = { name = "EC2-AZ1-WAS", enable_public_ip = false }
  "was2" = { name = "EC2-AZ3-WAS", enable_public_ip = false }
}


### 프라이빗 WAS NLB 설정 ###
nlb_was_pri = {
  nlb_name           = "NLBWAS-PRI"
  enable_internal    = true                  # 프라이빗
  load_balancer_type = "network"          # NLB 타입
}


### WAS NLB 타겟그룹 8080 포트 ###
nlb_was_target_8080 = {
  tg_name                 = "NLB-WAS-TG-8080"
  port                    = 8080
  protocol                = "TCP"
  target_type             = "instance"
  health_check_protocol   = "TCP"
  health_check_interval   = 30
  health_check_timeout    = 10
  healthy_threshold       = 5
  unhealthy_threshold     = 2
}


### WAS NLB 리스너 ###
was_8080_listner = {
  port                    = 8080
  protocol                = "TCP"
  type                    = "forward"
}


### RDS 서브넷 그룹 ###
db_subnet_group = {
  name                    = "dev-juno-rds-subnet-group"
}


### RDS 설정 ###
db_config = {
    allocated_storage           = 50
    max_allocated_storage       = 80
    skip_final_snapshot         = true
    publicly_accessible         = false
    auto_minor_version_upgrade  = false
    engine                      = "mysql"
    engine_version              = "8.0.35"
    instance_class              = "db.t3.micro"
  	enable_multi_az             = true
    identifier                  = "dev-juno-rds-mysql"
    storage_type                = "gp3"
    storage_encrypted           = true
    kms_key_id                  = "arn:aws:kms:ap-northeast-2:637423403127:key/9bb8c446-5cb3-44ce-9f38-915efca1e4c4"
    monitoring_interval         = 60
    monitoring_role_arn         = "arn:aws:iam::637423403127:role/rds-monitoring-role"
    backup_retention_period     = 1
    username                    = "admin"
    password                    = "test1234"
}