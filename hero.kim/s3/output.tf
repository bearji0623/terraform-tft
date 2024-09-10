output "web_bucket_arn" {
  description = "The ARN of the web S3 bucket"
  value       = module.s3_bucket_for_logs.s3_bucket_arn
}

output "web_bucket_domain_name" {
  description = "The domain name of the web S3 bucket"
  value       = module.s3_bucket_for_logs.s3_bucket_bucket_regional_domain_name
}

output "bucket_id" {
  value = module.s3_bucket_for_logs.s3_bucket_id
}