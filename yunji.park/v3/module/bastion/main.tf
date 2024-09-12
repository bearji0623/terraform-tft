resource "aws_instance" "bastion" {
    ami = var.ami
    instance_type = var.type
    ## ??
    key_name = output_key_id
    subnet_id = output_public_subnet_a_id
    vpc_security_group_ids = 
    associate_public_ip_address = var.enable_public_ip
    tags = {
      Name = var.bastion_name
    }


    vpc_security_group_ids = [aws_security_group.bastion_sg.id]
    

    root_block_device {
      volume_size = var.root_size
      volume_type = var.root_type
      delete_on_termination = var.root_delete_option
      tags = {
        Name = var.root_name
      }
    }
}

