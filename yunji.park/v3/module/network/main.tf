##################################################
# VPC
##################################################

resource "aws_vpc" "vpc" {
    cidr_block = var.vpc_cidr_block
    enable_dns_hostnames = true
    tags = {
        Name = var.vpc_name
    }
}

##################################################
# SUBNET
##################################################

# PUBLIC SUBNET A
resource "aws_subnet" "public_a" {
    vpc_id = aws_vpc.vpc.id
    availability_zone = var.az1
    cidr_block = var.public_a_subnet_cidr_block
    tags = {
        Name = var.public_a_subnet_name
    }
    map_public_ip_on_launch = true
}

# PUBLIC SUBNET C
resource "aws_subnet" "public_c" {
    vpc_id = aws_vpc.vpc.id
    availability_zone = var.az2
    cidr_block = var.public_c_subnet_cidr_block
    tags = {
        Name = var.public_c_subnet_name
    }
    map_public_ip_on_launch = true
}

# WEB Private Subnet A
resource "aws_subnet" "web_private_a" {
    vpc_id = aws_vpc.vpc.id
    availability_zone = var.az1
    cidr_block = var.web_private_a_subnet_cidr_block
    tags = {
        Name = var.web_private_a_subnet_name
    }
}

# WEB Private Subnet C
resource "aws_subnet" "web_private_c" {
    vpc_id = aws_vpc.vpc.id
    availability_zone = var.az2
    cidr_block = var.web_private_c_subnet_cidr_block
    tags = {
        Name = var.web_private_c_subnet_name
    }
}

# WAS Private Subnet A
resource "aws_subnet" "was_private_a" {
    vpc_id = aws_vpc.vpc.id
    availability_zone = var.az1
    cidr_block = var.was_private_a_subnet_cidr_block
    tags = {
        Name = var.was_private_a_subnet_name
    }
}

# WAS Private Subnet C
resource "aws_subnet" "was_private_c" {
    vpc_id = aws_vpc.vpc.id
    availability_zone = var.az2
    cidr_block = var.was_private_c_subnet_cidr_block
    tags = {
        Name = var.was_private_c_subnet_name
    }
}

# DB Private Subnet A
resource "aws_subnet" "db_private_a" {
    vpc_id = aws_vpc.vpc.id
    availability_zone = var.az1
    cidr_block = var.db_private_a_subnet_cidr_block
    tags = {
        Name = var.db_private_a_subnet_name
    }
}

# DB Private Subnet C
resource "aws_subnet" "db_private_c" {
    vpc_id = aws_vpc.vpc.id
    availability_zone = var.az2
    cidr_block = var.db_private_c_subnet_cidr_block
    tags = {
        Name = var.db_private_c_subnet_name
    }
}

##################################################
# IGW & NAT GW
##################################################

# Internet Gateway
resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.vpc.id
    tags = {
        Name = var.internet_gateway_name
    }
}

# EIP for NAT GW
resource "aws_eip" "nat_eip" {
    domain = aws_vpc.vpc.id

    lifecycle {
      create_before_destroy = true
    }
}

# NAT Gateway
resource "aws_nat_gateway" "nat_gw" {
    allocation_id = aws_eip.nat_eip.id
    subnet_id = aws_subnet.public_a.id

    tags = {
        Name = var.nat_gateway_name
    }
}

##################################################
# Route Table
##################################################

# PUBLIC ROUTE TABLE
resource "aws_route_table" "public_rt" {
    vpc_id = aws_vpc.vpc.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw.id
    }
    tags = {
        Name = var.public_route_name
    }
}

# PRIVATE ROUTE TABLE
resource "aws_route_table" "web_private_rt" {
    vpc_id = aws_vpc.vpc.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_nat_gateway.nat_gw.id
    }
    tags = {
        Name = var.web_private_rt_name
    }
}

resource "aws_route_table" "was_private_rt" {
    vpc_id = aws_vpc.vpc.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_nat_gateway.nat_gw.id
    }
    tags = {
        Name = var.was_private_rt_name
    }
}

resource "aws_route_table" "db_private_rt" {
    vpc_id = aws_vpc.vpc.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_nat_gateway.nat_gw.id
    }
    tags = {
        Name = var.db_private_rt_name
    }
}

# 위에서 생성해준 public routing table을 생성한 public subnet에 associate 해줘야 함
resource "aws_route_table_association" "public_a" {
    subnet_id = aws_subnet.public_a.id
    route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "public_c" {
    subnet_id = aws_subnet.public_c.id
    route_table_id = aws_route_table.public_rt.id
}

# 위에서 생성해준 private routing table을 생성한 private subnet에 associate 해줘야 함
resource "aws_route_table_association" "web_private_a" {
    subnet_id = aws_subnet.web_private_a.id
    route_table_id = aws_route_table.web_private_rt.id
}

resource "aws_route_table_association" "web_private_c" {
    subnet_id = aws_subnet.web_private_c.id
    route_table_id = aws_route_table.web_private_rt.id
}

resource "aws_route_table_association" "was_private_a" {
    subnet_id = aws_subnet.was_private_a.id
    route_table_id = aws_route_table.was_private_rt.id
}

resource "aws_route_table_association" "was_private_c" {
    subnet_id = aws_subnet.was_private_c.id
    route_table_id = aws_route_table.was_private_rt.id
}

resource "aws_route_table_association" "db_private_a" {
    subnet_id = aws_subnet.db_private_a.id
    route_table_id = aws_route_table.db_private_rt.id
}

resource "aws_route_table_association" "db_private_c" {
    subnet_id = aws_subnet.db_private_c.id
    route_table_id = aws_route_table.db_private_rt.id
}

