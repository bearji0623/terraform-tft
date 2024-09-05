### WEB ACL 생성 ###
resource "aws_wafv2_web_acl" "juno_web_acl" {
  name        = "JUNO-WEB-ACL"
  scope       = "REGIONAL"
  
  default_action {
    allow {}
  }
  
    visibility_config {
    cloudwatch_metrics_enabled = false
    metric_name                = "juno-rule-metric-name"
    sampled_requests_enabled   = false
  }
  
  rule {
    name     = "AWS-AWSManagedRulesCommonRuleSet"
    priority = 0
    override_action {
      none {
      }
    }
    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesCommonRuleSet"
        vendor_name = "AWS"

        rule_action_override {
          action_to_use {
            block {}
          }

          name = "NoUserAgent_HEADER" # 헤더가 없는 요청이면 block 
        }
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "AWS-AWSManagedRulesCommonRuleSet"
      sampled_requests_enabled   = true
    }
  }

}



### ALB 연결 ###
resource "aws_wafv2_web_acl_association" "juno-waf-alb-association" {
#  resource_arn = aws_api_gateway_stage.example.arn
  resource_arn = var.alb_pub_id
  web_acl_arn  = aws_wafv2_web_acl.juno_web_acl.arn
}