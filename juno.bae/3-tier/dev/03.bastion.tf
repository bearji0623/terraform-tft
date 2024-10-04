module "bastion" {
  source            = "../modules/bastion"
  
  ### 공통 ###
  env               = var.env
  project           = var.project
  
  ### 서브넷 ID ###
  subnet_id         = module.network.subnet_id  # network 모듈 output 전달
  
  ### SG ID ###
  bastion_sg_id     = module.sg.bastion_sg_id   # sg 모듈 output 전달
  
  ### EC2 설정 ###
  ec2_common        = var.ec2_common    # EC2 공통 설정 전달
  ec2_bastion       = var.ec2_bastion   # EC2 Bastion 설정 전달
  

}