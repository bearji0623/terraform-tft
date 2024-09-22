variable "region" {
  description = "The AWS region to Infra resources"
  default     = "ap-northeast-2"
}

variable "ami_id" {
  description = "The AMI ID for the EC2 instances"
  default     = "ami-00ff737803101edd1"
}
#################################
variable "route53_zone_id" {
  description = "The ID of the Route 53 hosted zone"
  type        = string
  default     = "Z0668592GCRH4LPCX73B"
}
