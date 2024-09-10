##ALB 생성
resource "aws_lb" "alb" {
  name               = "${var.id_num}-ALB"
  internal           = false
  load_balancer_type = "application"
  subnets            = [aws_subnet.public_a.id, aws_subnet.public_c.id]
  security_groups    = [aws_security_group.alb_sg.id]
 
  tags = {
    Name = "${var.id_num}-ALB"
  }
}
 
## ALB_리스너
resource "aws_lb_listener" "alb_listener" {
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
 
## ALB_대상 그룹
resource "aws_lb_target_group" "alb_tg" {
  name                 = "${var.id_num}-alb-tg"
  port                 = 80
  protocol             = "HTTP"
  vpc_id               = aws_vpc.vpc.id
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
resource "aws_lb_listener_rule" "alb_listener_rule" {
  listener_arn = aws_lb_listener.alb_listener.arn
  priority     = 100
 
  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb_tg.arn
  }
 
  condition {
    path_pattern {
      values = ["*"]
    }
  }
}

## 타겟그룹에 넣은 인스턴스 
resource "aws_lb_target_group_attachment" "alb_target1" {
  target_group_arn = aws_lb_target_group.alb_tg.arn
  target_id = aws_instance.web_a.id
  port = 80
}

resource "aws_lb_target_group_attachment" "alb_target2" {
  target_group_arn = aws_lb_target_group.alb_tg.arn
  target_id = aws_instance.web_c.id
  port = 80
}