terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      configuration_aliases = [
        aws.virginia,
      ]
    }
  }
}

resource "aws_acm_certificate" "virginia" {
  provider          = aws.virginia
  domain_name       = var.domain_name
  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Manageby = "Terraform"
  }
}

resource "aws_acm_certificate_validation" "acm" {
  provider               = aws.virginia
  certificate_arn        = aws_acm_certificate.virginia.arn
  validation_record_fqdns = [for record in aws_route53_record.acm : record.fqdn]
}

data "aws_route53_zone" "r53" {
  zone_id = var.route53_zone_id
}

resource "aws_route53_record" "acm" {
  provider = aws.virginia
  for_each = {
    for dvo in aws_acm_certificate.virginia.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      type   = dvo.resource_record_type
      record = dvo.resource_record_value
    }
  }

  zone_id = data.aws_route53_zone.r53.id
  name    = each.value.name
  type    = each.value.type
  ttl     = 60
  records = [each.value.record]
}