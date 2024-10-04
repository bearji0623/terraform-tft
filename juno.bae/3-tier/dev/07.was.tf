module "was" {
  source            = "../modules/was"
  
  ### 공통 ###
  env               = var.env
  project           = var.project
  
  ### 서브넷 ID ###
  subnet_id         = {
    "was1"  = module.network.subnet_id["was_subnet_a"]
    "was2"  = module.network.subnet_id["was_subnet_c"]
  }
  
  ### SG ID ###
  was_sg_id         = module.sg.was_ec2_sg_id
  
  ### EC 설정 ###
  ec2_common        = var.ec2_common  # EC2 공통 설정 전달
  ec2_was           = var.ec2_was     # EC2 WAS 설정 전달
}