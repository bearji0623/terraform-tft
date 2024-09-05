### RDS SUBNET GROUP ###
resource "aws_db_subnet_group" "juno_rds-subnet-group" {
  name = "juno-rds-subnet-group"
  subnet_ids = var.pri_sub_db_id
  tags = {
    "Name" = "juno-rds-subnet-group"
  }
}


### CREATE RDS ###
resource "aws_db_instance" "juno-rds-mysql" { 
    allocated_storage = 50
    max_allocated_storage = 80
    skip_final_snapshot = true
    vpc_security_group_ids = [aws_security_group.juno-sg-rds.id]
    db_subnet_group_name = aws_db_subnet_group.juno_rds-subnet-group.name
    publicly_accessible = false
    auto_minor_version_upgrade = false
    engine = "mysql"
    engine_version = "8.0.35"
    instance_class = "db.t3.micro"
	multi_az = true
    identifier = "juno-rds-mysql"
    storage_type = "gp3"
    storage_encrypted = true
    kms_key_id = "arn:aws:kms:ap-northeast-2:637423403127:key/9bb8c446-5cb3-44ce-9f38-915efca1e4c4"
    monitoring_interval = 60
    monitoring_role_arn = "arn:aws:iam::637423403127:role/rds-monitoring-role"
    backup_retention_period = 1
    username = "admin"
    password = "test1234"
    tags = {
        "Name" = "JUNO-RDS"
    }
}