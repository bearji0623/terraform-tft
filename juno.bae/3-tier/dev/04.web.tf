module "web" {
  source            = "../modules/web"
  
  ### 공통 ###
  env               = var.env
  project           = var.project
  
  ### 서브넷 ID ###
  subnet_id         = {
    "web1"  = module.network.subnet_id["web_subnet_a"]
    "web2"  = module.network.subnet_id["web_subnet_c"]
  }
  
 
  ### SG ID ###
  web_sg_id         = module.sg.web_ec2_sg_id
  
  ### EC 설정 ###
  ec2_common        = var.ec2_common  # EC2 공통 설정 전달
  ec2_web           = var.ec2_web     # EC2 WEB 설정 전달
}