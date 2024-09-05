### VPC 모듈 변수 선언 ###

variable "vpc_id" {}

variable "pri_sub_db_id" {
    type = list(string)
}
