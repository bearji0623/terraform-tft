module "network" {
    source = ["terraform-aws-modules/vpc/aws", "terraform-google-modules/network/google//modules/subnets"]

    name = var.vpc_name
    cidr = var.vpc_cidr

    azs = ["ap-northeast-2a", "ap-northeast-2c"]
    private_subnets = [, "10.0.12.0/24", "10.0.13.0/24", , "10.0.111.0/24", "10.0.112.0/24"]
    
    enable_nat_gateway = true
    enable_dns_hostnames = true

    subnets = [
        {
            subnet_name = "${var.vpc_name}_public_sub_a"
            subnet_ip = "10.0.0.0/25"
            subnet_region = azs[0]
        },
        {
            subnet_name = "${var.vpc_name}_public_sub_c"
            subnet_ip = "10.0.0.128/25"
            subnet_region = azs[1]
        },
        {
            subnet_name = "${var.vpc_name}_web_private_sub_a"
            subnet_ip = "10.0.11.0/24"
            subnet_region = azs[0]
        },
        {
            subnet_name = "${var.vpc_name}_web_private_sub_c"
            subnet_ip = "10.0.110.0/24"
            subnet_region = azs[1]
        },
        {
            subnet_name = "${var.vpc_name}_was_private_sub_a"
            subnet_ip = "10.0.12.0/24"
            subnet_region = azs[0]
        },
        {
            subnet_name = "${var.vpc_name}_was_private_sub_c"
            subnet_ip = "10.0.111.0/24"
            subnet_region = azs[1]
        },
        {
            subnet_name = "${var.vpc_name}_db_private_sub_a"
            subnet_ip = "10.0.13.0/24"
            subnet_region = azs[0]
        },
        {
            subnet_name = "${var.vpc_name}_db_private_sub_c"
            subnet_ip = "10.0.112.0/24"
            subnet_region = azs[1]
        }
    ]
}