data "aws_route53_zone" "r53" {
  zone_id = var.route53_zone_id
}

resource "aws_route53_record" "alb" {
  zone_id = data.aws_route53_zone.r53.zone_id
  name    = var.domain_name
  type    = "A"

  alias {
    name                   = var.cloudfront_distribution_domain_name
    zone_id                = var.cloudfront_distribution_hosted_zone_id
    evaluate_target_health = true
  }
}