variable "region" {
  description = "The AWS region to Infra resources"
  default     = "ap-northeast-2"
}

variable "route53_zone_id" {
  description = "The ID of the Route 53 hosted zone"
  type        = string
  default     = "Z0668592GCRH4LPCX73B"
}
#################################