# S3 생성
module "s3_bucket_for_logs" {
  source = "terraform-aws-modules/s3-bucket/aws"

  bucket     = var.bucket_web
  acl        = "private"

  # Allow deletion of non-empty bucket
  force_destroy = true

  control_object_ownership = true
  object_ownership         = "ObjectWriter"

  tags = {
    Manageby = "Terraform"
  }
}

resource "aws_s3_object" "test" {
  bucket = module.s3_bucket_for_logs.s3_bucket_id
  key    = "test/"
}

resource "aws_s3_bucket_policy" "bucket_policy_web" {
  bucket = module.s3_bucket_for_logs.s3_bucket_id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid = "AllowCloudFrontServicePrincipal",
        Effect = "Allow",
        Principal = {
          Service = "cloudfront.amazonaws.com"
        },
        Action = "s3:GetObject",
        Resource = "arn:aws:s3:::${module.s3_bucket_for_logs.s3_bucket_id}/*",
        Condition = {
          StringEquals = {
            "AWS:SourceArn" = var.cloudfront_distribution_arn
          }
        }
      }
    ]
  })

}