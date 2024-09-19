# NLB 생성
resource "aws_lb" "nlb" {
  name               = "${var.name}-NLB"
  internal           = true
  load_balancer_type = "network"
  subnets            = var.private_subnets

  enable_deletion_protection = false

  tags = {
    Name = "${var.name}-NLB"
  }
}

## NLB_리스너
resource "aws_lb_listener" "nlb" {
  load_balancer_arn = aws_lb.nlb.arn
  port              = 8080
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.ntg.arn
  }
}

# NLB_대상 그룹
resource "aws_lb_target_group" "ntg" {
  name     = "${var.name}-NLB"
  port     = 8080
  protocol = "TCP"
  vpc_id   = var.vpc_id

  health_check {
    protocol = "TCP"
    port     = "traffic-port"
  }
}

resource "aws_lb_target_group_attachment" "tft3" {
  target_group_arn = aws_lb_target_group.ntg.arn
  target_id        = var.target_instance_ids[0]  # 첫 번째 인스턴스 ID 사용
  port             = 8080
}

resource "aws_lb_target_group_attachment" "tft4" {
  target_group_arn = aws_lb_target_group.ntg.arn
  target_id        = var.target_instance_ids[1]  # 첫 번째 인스턴스 ID 사용
  port             = 8080
}