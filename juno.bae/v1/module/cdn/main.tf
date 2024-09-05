### 버킷 생성 ###
resource "aws_s3_bucket" "juno-terraform-mybucket" {
  bucket = "juno-origin-bucket"
}



### 파일 업로드1 ###
resource "aws_s3_object" "object1" {
  bucket = aws_s3_bucket.juno-terraform-mybucket.id
  key    = "index.html"
  source = "/home/ec2-user/environment/static/index.html"
  content_type = "text/html"
}

### 파일 업로드2  ###
resource "aws_s3_object" "object2" {
  bucket = aws_s3_bucket.juno-terraform-mybucket.id
  key    = "cat.jpg"
  source = "/home/ec2-user/environment/static/cat.jpg"
  content_type = "image/jpg"
}

### 버킷 정책 추가 ###
resource "aws_s3_bucket_policy" "juno_origin_bucket_policy" {
  bucket = aws_s3_bucket.juno-terraform-mybucket.id

  policy = jsonencode({
    Version = "2008-10-17"
    Id      = "PolicyForCloudFrontPrivateContent"
    Statement = [
      {
        Sid       = "AllowCloudFrontServicePrincipal"
        Effect    = "Allow"
        Principal = {
          Service = "cloudfront.amazonaws.com"
        }
        Action   = "s3:GetObject"
        Resource = "arn:aws:s3:::juno-origin-bucket/*"
        Condition = {
          StringEquals = {
            "AWS:SourceArn" = aws_cloudfront_distribution.juno-s3-distribution.arn
          }
        }
      }
    ]
  })
}




### Cloudfront 설정 ###
resource "aws_cloudfront_origin_access_control" "juno-cf-oac" {
  name                            = "juno_cloudfront_oac"
  origin_access_control_origin_type = "s3"
  signing_behavior                = "always"
  signing_protocol                = "sigv4"
}

resource "aws_cloudfront_distribution" "juno-s3-distribution" {
  origin {
    domain_name              = aws_s3_bucket.juno-terraform-mybucket.bucket_regional_domain_name
    origin_access_control_id = aws_cloudfront_origin_access_control.juno-cf-oac.id
    origin_id                = "juno-origin-bucket-origin"
  }

  enabled             = true
  is_ipv6_enabled     = true
  comment             = "juno test"
  default_root_object = "index.html"


  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "juno-origin-bucket-origin"
    
    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "allow-all"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }
}