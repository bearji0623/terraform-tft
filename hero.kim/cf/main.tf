module "cdn" {
  source  = "terraform-aws-modules/cloudfront/aws"
  version = "2.3.0"

  aliases = var.aliases
  comment             = "CloudFront_TFT"
  enabled             = true
  is_ipv6_enabled     = true
  price_class         = "PriceClass_200"
  retain_on_delete    = false
  wait_for_deployment = false
  web_acl_id          = var.web_acl_id

  default_cache_behavior = {
    target_origin_id       = "94102108-tft-s3"
    viewer_protocol_policy = "redirect-to-https"

    allowed_methods = ["GET", "HEAD"]
    cached_methods  = ["GET", "HEAD"]
    compress        = true
    query_string    = true

    forwarded_values = {
      query_string = false
      cookies = {
        forward = "none"
      }
    }
  }

  origin = [
  {
    domain_name = var.s3_origin_domain_name
    origin_id   = "94102108-tft-s3"
    origin_path = "/test"  # S3 원본의 루트 경로 사용 또는 유효한 경로 지정
    s3_oac = {
      domain_name              = var.s3_origin_domain_name
      origin_access_control_id = aws_cloudfront_origin_access_control.oac.id
    }
  },
  {
    domain_name = var.alb_dns_name
    origin_id   = "94102108-TFT-ALB"
    custom_origin_config = {
      http_port                = 80
      https_port               = 443
      origin_protocol_policy   = "http-only"
      origin_ssl_protocols     = ["TLSv1.2"]
      origin_keepalive_timeout = 5
      origin_read_timeout      = 30
    }
    # ALB 원본에는 origin_path를 설정하지 않음
  }
]

  viewer_certificate = {
    acm_certificate_arn      = var.acm_certificate_arn
    ssl_support_method       = "sni-only"
    minimum_protocol_version = "TLSv1.2_2021"
  }

  default_root_object = "index.html"

  ordered_cache_behavior = [
    {
      path_pattern           = "/"
      target_origin_id       = "94102108-TFT-ALB"
      viewer_protocol_policy = "redirect-to-https"

      allowed_methods = ["GET", "HEAD"]
      cached_methods  = ["GET", "HEAD"]
      compress        = true
      query_string    = true

      forwarded_values = {
        query_string = true
        cookies = {
          forward = "all"
        }
      }
    }
  ]
  
  tags = {
    Manageby = "Terraform"
}
}

resource "aws_cloudfront_origin_access_control" "oac" {
  name                              = "OAC_Trio"
  description                       = "OAC for Cloudfront Trio"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}