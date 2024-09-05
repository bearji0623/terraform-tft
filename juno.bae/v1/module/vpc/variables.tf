### VPC CIDR ###
variable "vpc_cidr" {
  description = "VPC CIDR"
  default = "10.0.0.0/16"
}


### 퍼블릭 서브넷 CIDR ###
variable "pub_sub_cidr" {
  description = "PUBLIC SUBNET CIDR"
  type = list(string)
  default = ["10.0.10.0/24", "10.0.20.0/24"]
}

### 프라이빗 서브넷 WEB CIDR ###
variable "pri_sub_web_cidr" {
  description = "PRIVATE SUBNET WEB CIDR"
  type = list(string)
  default = ["10.0.30.0/24", "10.0.40.0/24"]
}

### 프라이빗 서브넷 WAS CIDR ###
variable "pri_sub_was_cidr" {
  description = "PRIVATE SUBNET WAS CIDR"
  type = list(string)
  default = ["10.0.50.0/24", "10.0.60.0/24"]
}

### 프라이빗 서브넷 DB CIDR ###
variable "pri_sub_db_cidr" {
  description = "PRIVATE SUBNET DB CIDR"
  type = list(string)
  default = ["10.0.70.0/24", "10.0.80.0/24"]
}


### 가용영역 A, C ###
variable "az_list" {
    type = list(string)
    default = [ "ap-northeast-2a", "ap-northeast-2c" ]
}

locals {
  alphabet = ["A", "C"]
}