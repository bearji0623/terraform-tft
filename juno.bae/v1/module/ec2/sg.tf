### Bastion EC2 ###
resource "aws_security_group" "juno-sg-bastion-ec2" {
  vpc_id      = var.vpc_id
  name        = "JUNO-SG-BASTION-EC2"
  description = "JUNO-SG-BASTION-EC2"
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks     = ["27.122.137.92/32"]
    description = "NCLOUD"
  }
  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  tags = {
    Name = "JUNO-SG-BASTION-EC2"
  }
}


### Private EC2 WEB ###
resource "aws_security_group" "juno-sg-web-ec2" {
  vpc_id      = var.vpc_id
  name        = "JUNO-SG-WEB-EC2"
  description = "JUNO-SG-WEB-EC2"
  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    security_groups = [aws_security_group.juno-sg-webalb-pub.id]
  }
    ingress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    security_groups = [aws_security_group.juno-sg-webalb-pub.id]
  }
    ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks     = ["10.0.10.0/24"]
    description = "Bastion CIDR"
  }
  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  tags = {
    Name = "JUNO-SG-WEB-EC2"
  }
}


### Public WEB ALB ###
resource "aws_security_group" "juno-sg-webalb-pub" {
  vpc_id      = var.vpc_id
  name        = "JUNO-SG-WEBALB-PUB"
  description = "JUNO-SG-WEBALB-PUB"
  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  tags = {
    Name = "JUNO-SG-WEBALB-PUB"
  }
}


### SG PRIVATE WASNLB ###
resource "aws_security_group" "juno-sg-wasnlb-pri" {
  vpc_id      = var.vpc_id
  name        = "JUNO-SG-WASNLB-PRI"
  description = "JUNO-SG-WASNLB-PRI"
  ingress {
    from_port = 8080
    to_port = 8080
    protocol = "tcp"
    cidr_blocks     = ["10.0.11.0/24"]
    description = "WEB_SUB_A CIDR"
  }
    ingress {
    from_port = 8080
    to_port = 8080
    protocol = "tcp"
    cidr_blocks     = ["10.0.1.0/24"]
    description = "WEB_SUB_C CIDR"
  }
  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  tags = {
    Name = "JUNO-SG-WASNLB-PRI"
  }
}



### SG PRIVATE WAS EC2 ###
resource "aws_security_group" "juno-sg-was-ec2" {
  vpc_id      = var.vpc_id
  name        = "JUNO-SG-WAS-EC2"
  description = "JUNO-SG-WAS-EC2"
  ingress {
    from_port = 8080
    to_port = 8080
    protocol = "tcp"
    security_groups = [aws_security_group.juno-sg-wasnlb-pri.id]
  }
    ingress {
    from_port = 8080
    to_port = 8080
    protocol = "tcp"
    security_groups = [aws_security_group.juno-sg-wasnlb-pri.id]
  }
    ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks     = ["10.0.10.0/24"]
    description = "Bastion CIDR"
  }
  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  tags = {
    Name = "JUNO-SG-WAS-EC2"
  }
}


