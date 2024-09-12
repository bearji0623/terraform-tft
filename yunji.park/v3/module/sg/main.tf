## Bastion 보안 그룹
resource "aws_security_group" "bastion_sg" {
  name        = var.bastion_sg_name
  vpc_id      = output_vpc_id
 
  ingress {
    description = "ssh from AnyWhere"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
 
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
 
  lifecycle {
    create_before_destroy = true # 삭제 후 생성하기
  }
}

## ALB 보안그룹
resource "aws_security_group" "alb_sg" {
  name        = "${var.id_num}-laC-TFT-alb"
  description = "Security Group for ALB"
  vpc_id      = aws_vpc.vpc.id
 
  ingress {
    description = "HTTP from AnyWhere"
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
 
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
 
  lifecycle {
    create_before_destroy = true # 삭제 후 생성하기
  }
}
 
## WEB 서버 보안그룹
resource "aws_security_group" "web_sg" {
  name        = "${var.id_num}-laC-TFT-web"
  description = "Security Group for WEB server"
  vpc_id      = aws_vpc.vpc.id
 
  ingress {
    description = "ssh from Bastion"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    security_groups = [aws_security_group.bastion_sg.id]
  }
  
  ingress {
    description = "HTTP from AnyWhere"
    from_port = 80
    to_port = 80
    protocol = "tcp"
    security_groups = [aws_security_group.alb_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
 
  lifecycle {
    create_before_destroy = true # 삭제 후 생성하기
  }
}

## NLB 보안그룹 
resource "aws_security_group" "nlb_sg" {
  name        = "${var.id_num}-laC-TFT-nlb"
  description = "Security Group for NLB"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    description = "8080 from WEB Server"
    from_port = 8080
    to_port = 8080
    protocol = "tcp"
    security_groups = [aws_security_group.web_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
 
  lifecycle {
    create_before_destroy = true # 삭제 후 생성하기
  }
}


## WAS 서버 보안그룹
resource "aws_security_group" "was_sg" {
  name        = "${var.id_num}-laC-TFT-was"
  description = "Security Group for WAS server"
  vpc_id      = aws_vpc.vpc.id
 
  ingress {
    description = "ssh from Bastion"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    security_groups = [aws_security_group.bastion_sg.id]
  }
  
  ingress {
    description = "8080 from NLB"
    from_port = 8080
    to_port = 8080
    protocol = "tcp"
    security_groups = [aws_security_group.nlb_sg.id]
  }
  
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
 
  lifecycle {
    create_before_destroy = true # 삭제 후 생성하기
  }
}

## RDS 서버 보안그룹
resource "aws_security_group" "db_sg" {
  name        = "${var.id_num}-laC-TFT-db"
  description = "Security Group for DB Instance"
  vpc_id      = aws_vpc.vpc.id
 
  ingress {
    description = "3306 from WAS"
    from_port = 3306
    to_port = 3306
    protocol = "tcp"
    security_groups = [aws_security_group.was_sg.id]
  }
  
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
 
  lifecycle {
    create_before_destroy = true # 삭제 후 생성하기
  }
}