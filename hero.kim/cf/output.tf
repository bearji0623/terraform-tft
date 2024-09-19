output "cloudfront_distribution_id" {
  description = "The ID of the CloudFront distribution."
  value       = module.cdn.cloudfront_distribution_id
}

output "cloudfront_distribution_domain_name" {
  description = "The domain name corresponding to the distribution."
  value       = module.cdn.cloudfront_distribution_domain_name
}

output "cloudfront_distribution_arn" {
  description = "The ARN of the CloudFront distribution"
  value       = module.cdn.cloudfront_distribution_arn
}
output "cloudfront_distribution_hosted_zone_id" {
  description = "The Zone_ID of the CloudFront distribution"
  value       = module.cdn.cloudfront_distribution_hosted_zone_id
}