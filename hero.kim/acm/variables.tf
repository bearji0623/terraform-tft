variable "domain_name" {
  description = "The domain name for the ACM certificate"
  type        = string
}

variable "route53_zone_id" {
  description = "The ID of the existing Route 53 hosted zone"
  type        = string
}