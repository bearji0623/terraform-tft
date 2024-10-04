### PUBLIC ALB WEB 생성 ###
resource "aws_lb" "dev_juno_alb_web_pub" {
    name               = "${var.env}-${var.project}-${var.alb_web_pub.alb_name}"
    internal           = var.alb_web_pub.enable_internal
    load_balancer_type = var.alb_web_pub.load_balancer_type
    security_groups    = [var.webalb_sg_id]
    subnets            = var.subnet_id
}


### 80포트 타겟그룹 생성 ###
resource "aws_lb_target_group" "dev_juno_alb_web_tg_80" {
  name                  = "${var.project}-${var.alb_web_target_80.tg_name}"
  port                  = var.alb_web_target_80.port
  protocol              = var.alb_web_target_80.protocol
  vpc_id                = var.vpc_id
  target_type           = var.alb_web_target_80.target_type

  health_check {
    path                = var.alb_web_target_80.health_check_path
    protocol            = var.alb_web_target_80.health_check_protocol
    interval            = var.alb_web_target_80.health_check_interval
    timeout             = var.alb_web_target_80.health_check_timeout
    healthy_threshold   = var.alb_web_target_80.healthy_threshold
    unhealthy_threshold = var.alb_web_target_80.unhealthy_threshold
  }

  tags = {
    Name = "${var.env}-${var.project}-${var.alb_web_target_80.tg_name}"
  }
}


### ALB 타겟 그룹과 인스턴스 연결 ###
resource "aws_lb_target_group_attachment" "dev_juno_alb_web_tg_80_atth" {
  for_each           = var.web_ec2_id

  target_group_arn   = aws_lb_target_group.dev_juno_alb_web_tg_80.arn
  target_id          = each.value
  port               = var.alb_web_target_80.port
}



resource "aws_alb_listener" "juno-alb-web-listener" {
    load_balancer_arn = aws_lb.dev_juno_alb_web_pub.arn
    port = var.web_80_listner.port
    protocol = var.web_80_listner.protocol

    default_action {
      type = var.web_80_listner.type
      target_group_arn = aws_lb_target_group.dev_juno_alb_web_tg_80.arn
    }
  #   default_action {
  #     type = "redirect"

  #   redirect {
  #     host        = "#{host}"
  #     path        = "/#{path}"
  #     port        = "443"
  #     protocol    = "HTTPS"
  #     query       = "#{query}"
  #     status_code = "HTTP_301"
  #   }
  # }  
}

# # # ### ALB TLS 리스너 ###
# # # resource "aws_alb_listener" "juno-alb-tls-web-listner" {
# # #   load_balancer_arn = aws_alb.juno-alb-web-pub.arn
# # #   port              = 443
# # #   protocol          = "HTTPS"
# # #   ssl_policy        = "ELBSecurityPolicy-TLS13-1-2-2021-06"
# # #   certificate_arn   = var.acm_certificate_arn

# # #   default_action {
# # #     type             = "forward"
# # #     target_group_arn = aws_alb_target_group.juno-alb-web-tg-80.arn
# # #   }
# # # }