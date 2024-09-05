#Bastion 보안그룹 생성
resource "aws_security_group" "Bastion" {
  name        = "Bastion"
  description = "Security Group for Bastion"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    description = "Allow access from Cloud"
    cidr_blocks = ["165.243.5.20/32", "27.122.140.10/32"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"  // -1 means all protocols
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Bastion"
  }
}

#WEB 보안그룹 생성
resource "aws_security_group" "WEB" {
  name        = "WEB"
  description = "Security Group for WEB"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    description = "Allow access from Bastion"
    security_groups = [aws_security_group.Bastion.id]
  }
  
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    description = "Allow access from ALB"
    security_groups = [aws_security_group.Bastion.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"  // -1 means all protocols
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Manageby = "Terraform"
  }
}

#ALB 보안그룹 생성
resource "aws_security_group" "ALB" {
  name        = "ALB_Trio"
  description = "Security Group for ALB"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    description = "Allow access from HTTP"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    description = "Allow access from HTTPS"
    cidr_blocks = ["0.0.0.0/0"]
  }  

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"  // -1 means all protocols
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Manageby = "Terraform"
    Environment = "Trio"
  }
}
####################