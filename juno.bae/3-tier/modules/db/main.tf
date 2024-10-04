### RDS SUBNET GROUP 생성###
resource "aws_db_subnet_group" "dev_juno_rds_subnet_group" {
  name          = var.db_subnet_group.name
  subnet_ids    = var.db_subnet_id
  
  tags = {
    "Name"      = var.db_subnet_group.name
  }
}


### RDS 생성 ###
resource "aws_db_instance" "dev_juno_rds_mysql" { 
    allocated_storage           = var.db_config.allocated_storage
    max_allocated_storage       = var.db_config.max_allocated_storage
    skip_final_snapshot         = var.db_config.skip_final_snapshot
    vpc_security_group_ids      = [var.rds_sg_id]
    db_subnet_group_name        = aws_db_subnet_group.dev_juno_rds_subnet_group.name
    publicly_accessible         = var.db_config.publicly_accessible
    auto_minor_version_upgrade  = var.db_config.auto_minor_version_upgrade
    engine                      = var.db_config.engine
    engine_version              = var.db_config.engine_version
    instance_class              = var.db_config.instance_class
  	multi_az                    = var.db_config.enable_multi_az
    identifier                  = var.db_config.identifier
    storage_type                = var.db_config.storage_type
    storage_encrypted           = var.db_config.storage_encrypted
    kms_key_id                  = var.db_config.kms_key_id
    monitoring_interval         = var.db_config.monitoring_interval
    monitoring_role_arn         = var.db_config.monitoring_role_arn
    backup_retention_period     = var.db_config.backup_retention_period
    username                    = var.db_config.username
    password                    = var.db_config.password
}