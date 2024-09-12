module "bastion" {
  source = "../module/bastion"

  # AMI 
  ami = "ami-008d41dbe16db6778"

  # Instance Type
  type = "t2.micro"

  bastion_name = "${var.service}-${var.env}-bastion"

  # EBS Volume
  root_name = "${var.service}-${var.env}-bastion"
  root_size = 8
  root_type = "gp3"
  root_delete_option = true

  enable_public_ip = true
}

