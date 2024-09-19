variable "route53_zone_id" {
  description = "The ID of the existing Route 53 hosted zone"
  type        = string
}

variable "domain_name" {
  description = "The domain name for the Route 53 record"
  type        = string
}

variable "alb_domain_name" {
  description = "The domain name of the CloudFront distribution"
  type        = string
}

variable "alb_hosted_zone_id" {
  description = "The hosted zone ID for CloudFront"
  type        = string
}