#EC2 생성
module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"

  name = "Bastion"

  ami                    = var.ami_id
  instance_type          = var.instance_type_bastion
  key_name               = var.key_name
  vpc_security_group_ids = [var.bastion_sg_id]
  associate_public_ip_address = true
  subnet_id              = element(var.public_subnets, 0)

  tags = {
    Manageby = "Terraform"
  }
}

#EC2 생성
module "ec2_instance1" {
  source  = "terraform-aws-modules/ec2-instance/aws"

  name = "WEB1"

  ami                    = var.ami_id
  instance_type          = var.instance_type_web
  key_name               = var.key_name
  vpc_security_group_ids = [var.web_sg_id]
  subnet_id              = element(var.private_subnets, 0)
  user_data              = base64encode(templatefile("${path.module}/apache.sh.tpl", {NLB_DNS_NAME = var.nlb_dns_name}))

  tags = {
    Manageby = "Terraform"
  }
}

#EC2 생성
module "ec2_instance2" {
  source  = "terraform-aws-modules/ec2-instance/aws"

  name = "WEB2"

  ami                    = var.ami_id
  instance_type          = var.instance_type_web
  key_name               = var.key_name
  vpc_security_group_ids = [var.web_sg_id]
  subnet_id              = element(var.private_subnets, 1)
  user_data              = base64encode(templatefile("${path.module}/apache1.sh.tpl", {NLB_DNS_NAME = var.nlb_dns_name}))

  tags = {
    Manageby = "Terraform"
  }
}

module "ec2_instance3" {
  source  = "terraform-aws-modules/ec2-instance/aws"

  name = "WAS1"

  ami                    = var.ami_id
  instance_type          = var.instance_type_was
  key_name               = var.key_name
  vpc_security_group_ids = [var.was_sg_id]
  subnet_id              = element(var.private_subnets, 2)
  user_data              = base64encode(templatefile("${path.module}/tomcat.sh", { AWS_REGION = var.aws_region }))

  tags = {
    Manageby = "Terraform"
  }
}

module "ec2_instance4" {
  source  = "terraform-aws-modules/ec2-instance/aws"

  name = "WAS2"

  ami                    = var.ami_id
  instance_type          = var.instance_type_was
  key_name               = var.key_name
  vpc_security_group_ids = [var.was_sg_id]
  subnet_id              = element(var.private_subnets, 3)
  user_data              = base64encode(templatefile("${path.module}/tomcat1.sh", { AWS_REGION = var.aws_region }))

  tags = {
    Manageby = "Terraform"
  }
}
