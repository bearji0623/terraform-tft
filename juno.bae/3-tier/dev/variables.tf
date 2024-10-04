### 공통 ###
variable "env" {
  description = "워크로드 환경"
  type        = string
}

variable "project" {
  description = "프로젝트 이름"
  type        = string
}

### NETWORK ###
variable "vpc_cidr" {
  description = "VPC CIDR"
  type        = string
}

variable "enable_dns_hostnames" {
  description = "dns 호스트 이름 사용"
  type        = bool
}

variable "subnet" {
  description = "SUBNET CIDR 및 가용영역"
  type = map(object({
    cidr        = string
    az          = string
    name        = string
    route_table = string
  }))
}

variable "route_tables" {
  type  = map(object({
    name         = string
    is_public    = bool
  }))
}

variable "endpoint_type" {
  description = "엔드포인트 타입"
  type        = string
}

variable "endpoint_service_name" {
  description = "엔드포인트 이름"
  type        = string
}

variable "ec2_common" {
  description = "EC2 공통 설정"
  type = object({
    ami                   = string
    ec2_type              = string
    root_volume_size      = number
    root_volume_type      = string
    volume_encrypted      = bool
    kms_key_id            = string
    key_name              = string
  })
}

variable "ec2_bastion" {
  description = "Bastion 설정" 
  type = object({
    enable_public_ip      = bool
    name                  = string
  })
}

variable "ec2_web" {
  description = "WEB 설정" 
  type  = map(object({
    name                  = string
    enable_public_ip      = bool
    ebs_volume_size       = number
    ebs_volume_type       = string
    device_name           = string
    delete_on_termination = bool
  }))
}

variable "alb_web_pub" {
  description = "퍼블릭 WEB ALB 설정"
  type = object({
    alb_name           = string
    enable_internal    = bool
    load_balancer_type = string
  })
}

variable "alb_web_target_80" {
  description = "WEB ALB 타겟그룹 80포트"
  type = object({
    tg_name                 = string
    port                    = number
    protocol                = string
    target_type             = string
    health_check_path       = string
    health_check_protocol   = string
    health_check_interval   = number
    health_check_timeout    = number
    healthy_threshold       = number
    unhealthy_threshold     = number
  })
}

variable "web_80_listner" {
  description = "WEB ALB 80 리스너 설정"
  type = object({
  port                    = number
  protocol                = string
  type                    = string
  })
}

variable "ec2_was" {
  description = "WAS 설정" 
  type  = map(object({
    name                  = string
    enable_public_ip      = bool
  }))
}

variable "nlb_was_pri" {
  description = "프라이빗 WAS NLB 설정"
  type = object({
    nlb_name           = string
    enable_internal    = bool
    load_balancer_type = string
  })
}


variable "nlb_was_target_8080" {
  description = "WAS NLB 타겟그룹 8080포트"
  type = object({
    tg_name                 = string
    port                    = number
    protocol                = string
    target_type             = string
    health_check_protocol   = string
    health_check_interval   = number
    health_check_timeout    = number
    healthy_threshold       = number
    unhealthy_threshold     = number
  })
}

variable "was_8080_listner" {
  description = "WAS NLB 8080 리스너"
  type = object({
  port                    = number
  protocol                = string
  type                    = string
  })
}


variable "db_subnet_group" {
  description = "DB 서브넷 그룹"
  type = object({
    name        = string
  })
}


variable "db_config" {
  description = "DB 생성"
    type = object({
    allocated_storage           = number
    max_allocated_storage       = number
    skip_final_snapshot         = bool
    publicly_accessible         = bool
    auto_minor_version_upgrade  = bool
    engine                      = string
    engine_version              = string
    instance_class              = string
  	enable_multi_az             = bool
    identifier                  = string
    storage_type                = string
    storage_encrypted           = bool
    kms_key_id                  = string
    monitoring_interval         = number
    monitoring_role_arn         = string
    backup_retention_period     = number
    username                    = string
    password                    = string
  })
}