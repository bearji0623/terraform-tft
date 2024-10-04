### Bastion 생성 ###
resource "aws_instance" "dev_juno_ec2_bastion" {
  ami                         = var.ec2_common.ami
  instance_type               = var.ec2_common.ec2_type
  subnet_id                   = var.subnet_id["public_subnet_a"]
  key_name                    = var.ec2_common.key_name
  vpc_security_group_ids      = [var.bastion_sg_id]
  associate_public_ip_address = var.ec2_bastion.enable_public_ip
    
    root_block_device {
      volume_type             = var.ec2_common.root_volume_type
      volume_size             = var.ec2_common.root_volume_size
      encrypted               = var.ec2_common.volume_encrypted
      kms_key_id              = var.ec2_common.kms_key_id
    }
  
  tags = {
    Name = "${var.env}-${var.project}-${var.ec2_bastion.name}"
  }
}