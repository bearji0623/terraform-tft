### Bastion EC2 ###
resource "aws_security_group" "dev_juno_sg_bastion_ec2" {
  vpc_id            = var.vpc_id
  name              = "${var.env}-${var.project}-SG-BASTION-EC2"
  description       = "${var.env}-${var.project}-SG-BASTION-EC2"
  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    cidr_blocks     = ["27.122.137.92/32"]
    description     = "NCLOUD"
  }
  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.env}-${var.project}-SG-BASTION-EC2"
  }
}

### 퍼블릭 WEB ALB ###
resource "aws_security_group" "dev_juno_sg_webalb_pub" {
  vpc_id            = var.vpc_id
  name              = "${var.env}-${var.project}-SG-WEBALB-PUB"
  description       = "${var.env}-${var.project}-SG-WEBALB-PUB"
  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    cidr_blocks     = ["0.0.0.0/0"]
  }
  ingress {
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    cidr_blocks     = ["0.0.0.0/0"]
  }
  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.env}-${var.project}-SG-WEBALB-PUB"
  }
}

### 프라이빗 WEB EC2 ###
resource "aws_security_group" "dev_juno_sg_web_ec2" {
  vpc_id            = var.vpc_id
  name              = "${var.env}-${var.project}-SG-WEB-EC2"
  description       = "${var.env}-${var.project}-SG-WEB-EC2"
  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.dev_juno_sg_webalb_pub.id]
    description     = "PUBLIC WEB ALB"
  }
    ingress {
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    security_groups = [aws_security_group.dev_juno_sg_webalb_pub.id]
    description     = "PUBLIC WEB ALB"
  }
    ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.dev_juno_sg_bastion_ec2.id]
    description     = "Bastion"
  }
  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.env}-${var.project}-SG-WEB-EC2"
  }
}

### 프라이빗 WAS NLB ###
resource "aws_security_group" "dev_juno_sg_wasnlb_pri" {
  vpc_id            = var.vpc_id
  name              = "${var.env}-${var.project}-SG-WASNLB-PRI"
  description       = "${var.env}-${var.project}-SG-WASNLB-PRI"
  ingress {
    from_port       = 8080
    to_port         = 8080
    protocol        = "tcp"
    cidr_blocks     = ["10.0.30.0/24"]
    description     = "WEB A CIDR"
  }
    ingress {
    from_port       = 8080
    to_port         = 8080
    protocol        = "tcp"
    cidr_blocks     = ["10.0.40.0/24"]
    description     = "WEB C CIDR"
  }
  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.env}-${var.project}-SG-WASNLB-PRI"
  }
}

### SG PRIVATE WAS EC2 ###
resource "aws_security_group" "dev_juno_sg_was_ec2" {
  vpc_id            = var.vpc_id
  name              = "${var.env}-${var.project}-SG-WAS-EC2"
  description       = "${var.env}-${var.project}-SG-WAS-EC2"
  ingress {
    from_port       = 8080
    to_port         = 8080
    protocol        = "tcp"
    security_groups = [aws_security_group.dev_juno_sg_wasnlb_pri.id]
    description     = "PRIVATE WAS NLB"
  }
    ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.dev_juno_sg_bastion_ec2.id]
    description     = "Bastion"
  }
  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.env}-${var.project}-SG-WAS-EC2"
  }
}

### SG PRIVATE RDS ###
resource "aws_security_group" "dev_juno_sg_rds" {
  vpc_id            = var.vpc_id
  name              = "${var.env}-${var.project}-SG-RDS"
  description       = "${var.env}-${var.project}-SG-RDS"
  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    cidr_blocks     = ["10.0.50.0/24"]
    description     = "WAS A CIDR"
  }
    ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    cidr_blocks     = ["10.0.60.0/24"]
    description     = "WAS C CIDR"
  }
  
  tags = {
    Name = "${var.env}-${var.project}-SG-RDS"
  }
}