resource "aws_wafv2_ip_set" "ipset" {
  name               = "${var.name}-ipset"
  description        = "IPSet for ${var.name}"
  scope              = "REGIONAL"  # ALB와 연동할 때는 "REGIONAL"이어야 합니다.
  ip_address_version = "IPV4"
  addresses          = ["121.162.172.19/32"]  # 허용 또는 차단할 IP 주소 목록

  tags = {
    Name = "${var.name}-IPset"
  }
}

resource "aws_wafv2_web_acl" "waf" {
  name        = "${var.name}-WAF"
  scope       = "REGIONAL"
  description = "Web ACL for ${var.name} ALB"
  default_action {
    block {}
  }

  rule {
    name     = "IPSet-Rule"
    priority = 1
    action {
      allow {}  # 또는 allow {} 를 사용하여 IPSet에 해당하는 트래픽을 허용할 수 있습니다.
    }

    statement {
      ip_set_reference_statement {
        arn = aws_wafv2_ip_set.ipset.arn
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "ipsetRule"
      sampled_requests_enabled   = true
    }
  }

  visibility_config {
    cloudwatch_metrics_enabled = true
    metric_name                = "${var.name}-web-acl"
    sampled_requests_enabled   = true
  }
  
  tags = {
    Name = "${var.name}-WAF"
  }  
}

resource "aws_wafv2_web_acl_association" "waf" {
  resource_arn = var.alb_arn
  web_acl_arn   = aws_wafv2_web_acl.waf.arn
}