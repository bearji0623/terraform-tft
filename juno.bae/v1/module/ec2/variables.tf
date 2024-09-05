### EC2 변수 설정 ###
variable "ami_id" {
    default = "ami-07d737d4d8119ad79"
}

variable "ec2_type" {
    default = "t2.micro"
}


### VPC 모듈 변수 선언 ###
variable "vpc_id" {}

variable "pub_sub_id" {
    type = list(string)
}

variable "pri_sub_web_id" {
    type = list(string)
}

variable "pri_sub_was_id" {
    type = list(string)
}

variable "pri_sub_db_id" {
    type = list(string)
}


variable "acm_certificate_arn" {}

locals {
  number = ["1", "3"]
}