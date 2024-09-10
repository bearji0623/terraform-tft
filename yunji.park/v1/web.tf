resource "aws_instance" "web_a" {
    ami = "ami-008d41dbe16db6778"
    instance_type = "t2.micro"
    key_name = aws_key_pair.key.key_name
    subnet_id = aws_subnet.web_private_a.id
    vpc_security_group_ids = [aws_security_group.web_sg.id]

    root_block_device {
      volume_size = "8"
      volume_type = "gp3"
      delete_on_termination = "true"
      tags = {
        Name = "${var.id_num}-IaC-TFT-root-web-a"
      }
    }
}

resource "aws_instance" "web_c" {
    ami = "ami-008d41dbe16db6778"
    instance_type = "t2.micro"
    key_name = aws_key_pair.key.key_name
    subnet_id = aws_subnet.web_private_c.id
    vpc_security_group_ids = [aws_security_group.web_sg.id]

    root_block_device {
      volume_size = "8"
      volume_type = "gp3"
      delete_on_termination = "true"
      tags = {
        Name = "${var.id_num}-IaC-TFT-root-web-c"
      }
    }
}


