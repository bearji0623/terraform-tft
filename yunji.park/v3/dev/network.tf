module "network" {
    source = "../module/network"

    # VPC
    vpc_cidr_block = "10.0.0.0/16"
    vpc_name = "${var.service}-${var.env}-vpc"

    # AZ
    az1 = "ap-northeast-2a"
    az2 = "ap-northeast-2c"

    # PUBLIC SUBNET 
    public_a_subnet_cidr_block = "10.0.0.0/25"
    public_c_subnet_cidr_block = "10.0.0.128/25"
    
    public_a_subnet_name = "${var.service}-${var.env}-pub-sub-a"
    public_c_subnet_name = "${var.service}-${var.env}-pub-sub-c"

    # PRIVATE SUBNET
    web_private_a_subnet_cidr_block = "10.0.11.0/24"
    web_private_c_subnet_cidr_block = "10.0.110.0/24"
    
    was_private_a_subnet_cidr_block = "10.0.12.0/24"
    was_private_c_subnet_cidr_block = "10.0.120.0/24"
    
    db_private_a_subnet_cidr_block = "10.0.13.0/24"
    db_private_c_subnet_cidr_block = "10.0.130.0/24"

    web_private_a_subnet_name = "${var.service}-${var.env}-web-pri-sub-a"
    web_private_c_subnet_name = "${var.service}-${var.env}-web-pri-sub-c"

    was_private_a_subnet_name = "${var.service}-${var.env}-was-pri-sub-a"
    was_private_c_subnet_name = "${var.service}-${var.env}-was-pri-sub-c"

    db_private_a_subnet_name = "${var.service}-${var.env}-db-pri-sub-a"
    db_private_c_subnet_name = "${var.service}-${var.env}-db-pri-sub-c"
    
    # INTERNET GATEWAY
    internet_gateway_name = "${var.service}-${var.env}-igw"

    # NAT GATEWAY
    nat_gateway_name = "${var.service}-${var.env}-ngw"
    
    # PUBLIC ROUTE TABLE
    public_route_name = "${var.service}-${var.env}-pub-rt"
    
    # PRIVATE ROUTE TABLE 
    web_private_rt_name = "${var.service}-${var.env}-web-pri-rt"
    was_private_rt_name = "${var.service}-${var.env}-was-pri-rt"
    db_private_rt_name = "${var.service}-${var.env}-db-pri-rt"
}