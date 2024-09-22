module "db" {
  source = "terraform-aws-modules/rds/aws"

  identifier = var.identifier

  engine            = var.engine
  engine_version    = var.engine_version
  instance_class    = var.instance_class
  allocated_storage = var.allocated_storage
  db_subnet_group_name  = aws_db_subnet_group.subnet_group.name

  db_name   = var.db_name
  username  = var.user_name
  password  = var.password
  port      = var.port

  iam_database_authentication_enabled = true
  auto_minor_version_upgrade          = false
  multi_az                            = false
  skip_final_snapshot  = true

  vpc_security_group_ids = [var.rds_sg_id]

  # DB parameter group
  family = "mysql5.7"

  # DB option group
  major_engine_version = "5.7"

  tags = {
    Manageby = "Terraform"
  }
}

# DB 서브넷 그룹 생성
resource "aws_db_subnet_group" "subnet_group" {
  name       = var.db_subnet_group_name
  description = "Mysql DB Subnet Group"
  
  subnet_ids = slice(var.private_subnets, 4, 6)   # 사용할 서브넷 목록
  
  tags = {
    Manageby = "Terraform"
  }
}