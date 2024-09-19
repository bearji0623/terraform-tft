variable "aliases" {
  description = "A list of aliases (CNAMEs) to associate with the distribution."
  type        = list(string)
}

variable "acm_certificate_arn" {
  description = "The ARN of the ACM certificate for the CloudFront distribution."
  type        = string
}

variable "default_origin_domain_name" {
  description = "The default domain name for the origin."
  type        = string
}

variable "s3_origin_domain_name" {
  description = "The domain name of the S3 bucket for web."
  type        = string
}

variable "alb_dns_name" {
  description = "The DNS name of the ALB."
  type        = string
}

# 필요한 다른 변수들도 여기에 추가합니다.
variable "web_acl_id" {
  description = "The ARN of the WAFv2 Web ACL to associate with the CloudFront distribution"
  type        = string
}

variable "bucket_id" {
  description = "The ID of the S3 bucket"
  type        = string
}