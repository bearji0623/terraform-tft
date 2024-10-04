### WAS 서버 생성 ###
resource "aws_instance" "dev_juno_ec2" {
  for_each                    = var.ec2_was  # for_each로 각 웹 서버 생성

  ami                         = var.ec2_common.ami
  instance_type               = var.ec2_common.ec2_type
  subnet_id                   = var.subnet_id[each.key] 
  key_name                    = var.ec2_common.key_name
  vpc_security_group_ids      = [var.was_sg_id]
  associate_public_ip_address = each.value.enable_public_ip

  root_block_device {
    volume_type               = var.ec2_common.root_volume_type
    volume_size               = var.ec2_common.root_volume_size
    encrypted                 = var.ec2_common.volume_encrypted
    kms_key_id                = var.ec2_common.kms_key_id
  }

  user_data = file("${path.module}/script/install_tomcat.sh")

  tags = {
    Name = "${var.env}-${var.project}-${each.value.name}"
  }
}

