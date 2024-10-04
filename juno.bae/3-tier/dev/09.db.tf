module "db" {
  source                = "../modules/db"
  
  env                   = var.env
  project               = var.project
  
  ### 서브넷 ID ###
  db_subnet_id         = [
    module.network.subnet_id.db_subnet_a,
    module.network.subnet_id.db_subnet_c
  ]
  
  db_subnet_group       = var.db_subnet_group
  db_config             = var.db_config
  rds_sg_id             = module.sg.rds_sg_id
}