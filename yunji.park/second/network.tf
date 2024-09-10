module "network" {
    source = "./module/network"
    
    # VPC
    vpc_cidr_block = "10.0.0.0/24"
    vpc_name = "${var.name}-terraform-vpc"

    # AZ
    az_a = "ap-northeast-2a"
    az_c = "ap-northeast-2c"
    
    # PUBLIC SUBNET
    public_a_subnet_cidr_block = "10.0.0.0/25"
    public_c_subnet_cidr_block = "10.0.0.128/25"
    
    public_a_subnet_name = "${var.name}-terraform-pub-sub-a"
    public_c_subnet_name = "${var.name}-terraform-pub-sub-c"
    
    # INTERNET GATEWAY
    internet_gateway_name = "${var.name}-terraform-igw"
    
    # PUBLIC ROUTE TABLE
    public_route_name = "${var.name}-terraform-public-rt"
    
    # PRIVATE SUBNET
    web_private_a_subnet_cidr_block = "10.0.11.0/24"
    web_private_c_subnet_cidr_block = "10.0.110.0/24"
    
    was_private_a_subnet_cidr_block = "10.0.12.0/24"
    was_private_c_subnet_cidr_block = "10.0.120.0/24"
    
    db_private_a_subnet_cidr_block = "10.0.13.0/24"
    db_private_c_subnet_cidr_block = "10.0.130.0/24"

    web_private_a_subnet_name = "${var.name}-terraform-web-pri-sub-a"
    web_private_c_subnet_name = "${var.name}-terraform-web-pri-sub-c"

    was_private_a_subnet_name = "${var.name}-terraform-was-pri-sub-a"
    was_private_c_subnet_name = "${var.name}-terraform-was-pri-sub-c"

    db_private_a_subnet_name = "${var.name}-terraform-db-pri-sub-a"
    db_private_c_subnet_name = "${var.name}-terraform-db-pri-sub-c"

    # NAT GATEWAY
    nat_gateway_name = "${var.name}-terraform-ngw"
    
    # PRIVATE ROUTE TABLE 
    web_private_rt_name = "${var.name}-terraform-web-private-rt"
    was_private_rt_name = "${var.name}-terraform-was-private-rt"
    db_private_rt_name = "${var.name}-terraform-db-private-rt"
}