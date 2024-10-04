### WEB 서버 생성 ###
resource "aws_instance" "dev_juno_ec2" {
  for_each                    = var.ec2_web  # for_each로 각 웹 서버 생성

  ami                         = var.ec2_common.ami
  instance_type               = var.ec2_common.ec2_type
  subnet_id                   = var.subnet_id[each.key]  # 각 웹 서버의 서브넷 ID
  key_name                    = var.ec2_common.key_name
  vpc_security_group_ids      = [var.web_sg_id]
  associate_public_ip_address = each.value.enable_public_ip

  root_block_device {
    volume_type               = var.ec2_common.root_volume_type
    volume_size               = var.ec2_common.root_volume_size
    encrypted                 = var.ec2_common.volume_encrypted
    kms_key_id                = var.ec2_common.kms_key_id
  }

  ebs_block_device {
    device_name               = each.value.device_name
    volume_size               = each.value.ebs_volume_size
    volume_type               = each.value.ebs_volume_type
    encrypted                 = var.ec2_common.volume_encrypted
    kms_key_id                = var.ec2_common.kms_key_id
    delete_on_termination     = each.value.delete_on_termination
    
  }
  
  user_data = file("${path.module}/script/install_apache.sh")

  tags = {
    Name = "${var.env}-${var.project}-${each.value.name}"
  }
}

