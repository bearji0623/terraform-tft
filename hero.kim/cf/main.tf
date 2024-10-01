resource "aws_cloudfront_distribution" "cdn" {
  enabled             = true
  is_ipv6_enabled     = true
  comment             = "CloudFront_TFT"
  price_class         = "PriceClass_200"
  retain_on_delete    = false
  wait_for_deployment = false
  web_acl_id          = var.web_acl_id
  default_root_object = "index.html"

  origin {
    domain_name              = var.s3_origin_domain_name
    origin_id                = "94102108-tft-s3"
    origin_path              = "/test"
    origin_access_control_id = aws_cloudfront_origin_access_control.oac.id
  }

  origin {
    domain_name = var.alb_dns_name
    origin_id   = "94102108-TFT-ALB"
    custom_origin_config {
      http_port                = 80
      https_port               = 443
      origin_protocol_policy   = "http-only"
      origin_ssl_protocols     = ["TLSv1.2"]
      origin_keepalive_timeout = 5
      origin_read_timeout      = 30
    }
  }

  default_cache_behavior {
    target_origin_id       = "94102108-tft-s3"
    viewer_protocol_policy = "redirect-to-https"

    allowed_methods = ["GET", "HEAD"]
    cached_methods  = ["GET", "HEAD"]
    compress        = true

    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }

    min_ttl     = 0
    default_ttl = 3600
    max_ttl     = 86400
  }

  ordered_cache_behavior {
    path_pattern           = "/"
    target_origin_id       = "94102108-TFT-ALB"
    viewer_protocol_policy = "redirect-to-https"

    allowed_methods = ["GET", "HEAD"]
    cached_methods  = ["GET", "HEAD"]
    compress        = true

    forwarded_values {
      query_string = true
      cookies {
        forward = "all"
      }
    }

    min_ttl     = 0
    default_ttl = 3600
    max_ttl     = 86400
  }

  viewer_certificate {
    acm_certificate_arn      = var.acm_certificate_arn
    ssl_support_method       = "sni-only"
    minimum_protocol_version = "TLSv1.2_2021"
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  tags = {
    Manageby    = "Terraform"
    Environment = "TFT"
  }
  
  depends_on = [aws_cloudfront_origin_access_control.oac]
}


resource "aws_cloudfront_origin_access_control" "oac" {
  name                              = "OAC_TFT"
  description                       = "OAC for Cloudfront TFT"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}