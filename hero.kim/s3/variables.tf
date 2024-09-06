variable "bucket_web" {
  description = "The name of the web bucket"
  type        = string
  default     = "bucket-web-trio"
}

variable "cloudfront_distribution_arn" {
  description = "The ARN of the CloudFront distribution"
  type        = string
}