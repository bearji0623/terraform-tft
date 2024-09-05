### EC2 생성 - Bastion ###
resource "aws_instance" "juno-ec2-bastion" {
  count = 1
  ami           = var.ami_id
  instance_type = var.ec2_type
  subnet_id = element(var.pub_sub_id, count.index)
  key_name = "94102047-2"
  vpc_security_group_ids = [aws_security_group.juno-sg-bastion-ec2.id]
  associate_public_ip_address = true
    
    root_block_device {
      volume_type = "gp3"
      volume_size = 8
      encrypted = true
      kms_key_id = "arn:aws:kms:ap-northeast-2:637423403127:key/939c560c-8cde-41dc-b1dc-6bdf92c51e5a"
    }
  
  tags = {
    Name = "JUNO-EC2-AZ${local.number[count.index]}-BASTION"
  }
}


### EC2 생성 - Private WEB ###
resource "aws_instance" "juno-ec2-web" {
  count = 2
  ami           = var.ami_id
  instance_type = var.ec2_type
  subnet_id = element(var.pri_sub_web_id, count.index)
  key_name = "94102047-2"
  vpc_security_group_ids = [aws_security_group.juno-sg-web-ec2.id]
  associate_public_ip_address = false
    
    root_block_device {
      volume_type = "gp3"
      volume_size = 8
      encrypted = true
      kms_key_id = "arn:aws:kms:ap-northeast-2:637423403127:key/939c560c-8cde-41dc-b1dc-6bdf92c51e5a"
    }
    
    user_data = file("${path.module}/script/install_apache.sh")
  
  tags = {
    Name = "JUNO-EC2-AZ${local.number[count.index]}-WEB${count.index + 1}"
  }
}


### EC2 생성 - Private WAS ###
resource "aws_instance" "juno-ec2-was" {
  count = 2
  ami           = var.ami_id
  instance_type = var.ec2_type
  subnet_id = element(var.pri_sub_was_id, count.index)
  key_name = "94102047-2"
  vpc_security_group_ids = [aws_security_group.juno-sg-was-ec2.id]
  associate_public_ip_address = false
    
    root_block_device {
      volume_type = "gp3"
      volume_size = 8
      encrypted = true
      kms_key_id = "arn:aws:kms:ap-northeast-2:637423403127:key/939c560c-8cde-41dc-b1dc-6bdf92c51e5a"
    }
    
    user_data = file("${path.module}/script/install_tomcat.sh")
  
  tags = {
    Name = "JUNO-EC2-AZ${local.number[count.index]}-WAS${count.index + 1}"
  }
}






### Public WEBALB 생성 ###
resource "aws_alb" "juno-alb-web-pub" {
    name = "JUNO-ALB-WEB-PUB"
    internal = false
    load_balancer_type = "application"
    security_groups = [aws_security_group.juno-sg-webalb-pub.id ]
    subnets = var.pub_sub_id
}

resource "aws_alb_target_group" "juno-alb-web-tg-80" {
    name = "JUNO-ALB-WEB-TG-80"
    port = 80
    protocol = "HTTP"
    vpc_id = var.vpc_id
}

resource "aws_alb_target_group_attachment" "juno-alb-web-tg-80-atth" {
    count = 2
    target_group_arn = aws_alb_target_group.juno-alb-web-tg-80.arn
    target_id = element(aws_instance.juno-ec2-web.*.id, count.index)
    port = 80
}

resource "aws_alb_listener" "juno-alb-web-listener" {
    load_balancer_arn = aws_alb.juno-alb-web-pub.arn
    port = "80"
    protocol = "HTTP"

    # default_action {
    #   type = "forward"
    #   target_group_arn = aws_alb_target_group.juno-alb-web-tg-80.arn
    # }
    default_action {
      type = "redirect"

    redirect {
      host        = "#{host}"
      path        = "/#{path}"
      port        = "443"
      protocol    = "HTTPS"
      query       = "#{query}"
      status_code = "HTTP_301"
    }
  }  
}

### ALB TLS 리스너 ###
resource "aws_alb_listener" "juno-alb-tls-web-listner" {
  load_balancer_arn = aws_alb.juno-alb-web-pub.arn
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-TLS13-1-2-2021-06"
  certificate_arn   = var.acm_certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.juno-alb-web-tg-80.arn
  }
}



### Private WASNLB 생성 ###
resource "aws_alb" "juno-nlb-was-pri" {
    name = "JUNO-NLB-WAS-PRI"
    internal = true
    load_balancer_type = "network"
    security_groups = [ aws_security_group.juno-sg-wasnlb-pri.id ]
    
    subnets = var.pri_sub_web_id
}

resource "aws_alb_target_group" "juno-nlb-was-tg-8080" { 
    name = "JUNO-NLB-WAS-TG-8080"
    port = 8080
    protocol = "TCP"
    vpc_id = var.vpc_id
}

resource "aws_alb_target_group_attachment" "juno-nlb-was-tg-8080-atth" {
    count = 2
    target_group_arn = aws_alb_target_group.juno-nlb-was-tg-8080.arn
    target_id = element(aws_instance.juno-ec2-was.*.id, count.index)
    port = 8080
}

resource "aws_alb_listener" "juno-nlb-was-listener" {
    load_balancer_arn = aws_alb.juno-nlb-was-pri.arn
    port = "8080"
    protocol = "TCP"

    default_action {
      type = "forward"
      target_group_arn = aws_alb_target_group.juno-nlb-was-tg-8080.arn
    }
}