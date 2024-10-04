module "sg" {
  source          = "../modules/sg"
  
  env             = var.env
  project         = var.project
  
  vpc_id          = module.network.vpc_id
  

}