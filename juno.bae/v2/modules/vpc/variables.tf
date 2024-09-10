### 공통 대그 ###
variable "env" {
  type = string
}

variable "project" {
  type = string
}


### VPC CIDR ###
variable "vpc_cidr" {
  description = "VPC CIDR"
  default = "10.0.0.0/16"
}