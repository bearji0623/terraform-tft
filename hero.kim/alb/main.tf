##ALB 생성
resource "aws_lb" "alb" {
  name               = "${var.name}-ALB"
  internal           = false
  load_balancer_type = "application"
  subnets            = var.public_subnets
  security_groups    = [var.alb_sg_id]

  tags = {
    Manageby = "Terraform"
  }
}

## ALB_리스너
resource "aws_lb_listener" "alb" {
  load_balancer_arn = aws_lb.alb.arn
  port              = 80
  protocol          = "HTTP"

  # By default, return a simple 404 page
  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "404: page not found/n"
      status_code  = 404
    }
  }
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.alb.arn
  port              = 443   # ALB 리스너 포트
  protocol          = "HTTPS" # ALB 리스너 프로토콜
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = data.aws_acm_certificate.acm.arn
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.atg.arn
  }
}

## ALB_대상 그룹
resource "aws_lb_target_group" "atg" {
  name                 = "${var.name}-ALB"
  port                 = 80
  protocol             = "HTTP"
  vpc_id               = var.vpc_id
  deregistration_delay = 0

  health_check {
    path                = "/"
    protocol            = "HTTP"
    matcher             = "200"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 3
    unhealthy_threshold = 2
  }
}
### ALB_리스너 규칙
resource "aws_lb_listener_rule" "asg" {
  listener_arn = aws_lb_listener.alb.arn
  priority     = 100

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.atg.arn
  }

  condition {
    path_pattern {
      values = ["*"]
    }
  }
}

resource "aws_lb_target_group_attachment" "tft1" {
  target_group_arn = aws_lb_target_group.atg.arn
  target_id        = var.target_instance_ids[0]  # 첫 번째 인스턴스 ID 사용
  port             = 80
}

resource "aws_lb_target_group_attachment" "tft2" {
  target_group_arn = aws_lb_target_group.atg.arn
  target_id        = var.target_instance_ids[1]  # 두 번째 인스턴스 ID 사용
  port             = 80
}

# ACM 인증서 요청
data "aws_acm_certificate" "acm" {
  domain   = "*.btiucloud.com"  # ACM 인증서에 연결된 도메인 이름
  most_recent = true  # 최신의 인증서를 선택
}