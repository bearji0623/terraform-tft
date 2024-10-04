module "alb" {
  source                = "../modules/alb"
  
  ### 공통 ###
  env                   = var.env
  project               = var.project

  alb_web_pub           = var.alb_web_pub
  webalb_sg_id          = module.sg.webalb_sg_id

  vpc_id                = module.network.vpc_id
  subnet_id      = [
    module.network.subnet_id.public_subnet_a,
    module.network.subnet_id.public_subnet_c
  ]
  
  alb_web_target_80     = var.alb_web_target_80
  web_80_listner        = var.web_80_listner
  web_ec2_id            = module.web.web_ec2_id
}