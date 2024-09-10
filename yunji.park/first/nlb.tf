## NLB 생성
resource "aws_lb" "nlb" {
  name               = "${var.id_num}-NLB"
  internal           = true
  load_balancer_type = "network"
  subnets            = [aws_subnet.was_private_a.id, aws_subnet.was_private_c.id]
 
  tags = {
    Name = "${var.id_num}-NLB"
  }
}
 
## NLB_리스너
resource "aws_lb_listener" "nlb_listener" {
  load_balancer_arn = aws_lb.nlb.arn
  port              = 8080
  protocol          = "TCP"
  
  # By default, return a simple 404 page
  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.nlb_tg.arn
  }
}
 
## NLB_대상 그룹
resource "aws_lb_target_group" "nlb_tg" {
  name                 = "${var.id_num}-nlb-tg"
  port                 = 8080
  protocol             = "TCP"
  vpc_id               = aws_vpc.vpc.id
 
  # health_check {
  #   protocol = "TCP"
  #   port     = "traffic-port"
  # }
}

## 타겟그룹에 넣은 인스턴스 
resource "aws_lb_target_group_attachment" "nlb_target1" {
  target_group_arn = aws_lb_target_group.nlb_tg.arn
  target_id = aws_instance.was_a.id
  port = 8080
  depends_on = [aws_lb_target_group.nlb_tg]
}

resource "aws_lb_target_group_attachment" "nlb_target2" {
  target_group_arn = aws_lb_target_group.nlb_tg.arn
  target_id = aws_instance.was_c.id
  port = 8080
  depends_on = [aws_lb_target_group.nlb_tg]
}