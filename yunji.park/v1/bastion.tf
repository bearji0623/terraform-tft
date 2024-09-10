resource "aws_instance" "bastion" {
    ami = "ami-008d41dbe16db6778"
    instance_type = "t2.micro"
    key_name = aws_key_pair.key.key_name
    subnet_id = aws_subnet.public_a.id
    vpc_security_group_ids = [aws_security_group.bastion_sg.id]
    associate_public_ip_address = true

    root_block_device {
      volume_size = "8"
      volume_type = "gp3"
      delete_on_termination = "true"
      tags = {
        Name = "${var.id_num}-IaC-TFT-root-Bastion"
      }
    }
}

