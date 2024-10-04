module "nlb" {
  source                = "../modules/nlb"
  
  ### 공통 ###
  env                   = var.env
  project               = var.project

  nlb_was_pri           = var.nlb_was_pri
  wasnlb_sg_id          = module.sg.wasnlb_sg_id

  vpc_id                = module.network.vpc_id
  subnet_id     = [
    module.network.subnet_id.web_subnet_a,
    module.network.subnet_id.web_subnet_c
  ]
  
  nlb_was_target_8080   = var.nlb_was_target_8080
  was_8080_listner      = var.was_8080_listner  
  was_ec2_id            = module.was.was_ec2_id
}