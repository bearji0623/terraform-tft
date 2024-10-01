variable "bucket_web" {
  description = "The name of the web bucket"
  type        = string
  default     = "94102108-tft-s3"
}

variable "cloudfront_distribution_arn" {
  description = "The ARN of the CloudFront distribution"
  type        = string
}