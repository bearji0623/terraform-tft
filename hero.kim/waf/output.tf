output "cloudfront_web_acl_arn" {
  value = aws_wafv2_web_acl.waf.arn
}