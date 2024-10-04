### PRIVATE NLB WEB 생성 ###
resource "aws_lb" "dev_juno_nlb_was_pri" {
    name               = "${var.env}-${var.project}-${var.nlb_was_pri.nlb_name}"
    internal           = var.nlb_was_pri.enable_internal
    load_balancer_type = var.nlb_was_pri.load_balancer_type
    security_groups    = [var.wasnlb_sg_id]
    subnets            = var.subnet_id
}

### 8080 포트 타겟그룹 생성 ###
resource "aws_lb_target_group" "dev_juno_nlb_was_tg_8080" {
  name                  = "${var.project}-${var.nlb_was_target_8080.tg_name}"
  port                  = var.nlb_was_target_8080.port
  protocol              = var.nlb_was_target_8080.protocol
  vpc_id                = var.vpc_id
  target_type           = var.nlb_was_target_8080.target_type

  health_check {
    protocol            = var.nlb_was_target_8080.health_check_protocol
    interval            = var.nlb_was_target_8080.health_check_interval
    timeout             = var.nlb_was_target_8080.health_check_timeout
    healthy_threshold   = var.nlb_was_target_8080.healthy_threshold
    unhealthy_threshold = var.nlb_was_target_8080.unhealthy_threshold
  }

  tags = {
    Name = "${var.env}-${var.project}-${var.nlb_was_target_8080.tg_name}"
  }
}


### ALB 타겟 그룹과 인스턴스 연결 ###
resource "aws_lb_target_group_attachment" "dev_juno_nlb_was_tg_8080_atth" {
  for_each           = var.was_ec2_id

  target_group_arn   = aws_lb_target_group.dev_juno_nlb_was_tg_8080.arn
  target_id          = each.value
  port               = var.nlb_was_target_8080.port
}


resource "aws_alb_listener" "juno-nlb-was-listener" {
    load_balancer_arn = aws_lb.dev_juno_nlb_was_pri.arn
    port = var.was_8080_listner.port
    protocol = var.was_8080_listner.protocol

    default_action {
      type = var.was_8080_listner.type
      target_group_arn = aws_lb_target_group.dev_juno_nlb_was_tg_8080.arn
    }
}