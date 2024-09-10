# RDS 생성

## RDS Subnet Group 생성 
resource "aws_db_subnet_group" "db_subnet_group" {
    name = "yunji-iac-tft-db-subnet-group"
    subnet_ids = [aws_subnet.db_private_a.id, aws_subnet.db_private_c.id]
    
    tags = {
        name = "${var.id_num}-IaC-TFT-db-subnet-group"
    }
}

## RDS 생성
resource "aws_db_instance" "db" {
    identifier = "yunji-iac-tft-db"
    allocated_storage = 5
    engine = "mysql"
    engine_version = "5.7"
    db_name = "db_yunji"
    instance_class = "db.t3.medium"
    multi_az = true
    username = "admin"
    password = "a12345678"
    db_subnet_group_name = aws_db_subnet_group.db_subnet_group.name
    vpc_security_group_ids = [aws_security_group.db_sg.id]
    skip_final_snapshot = true
}