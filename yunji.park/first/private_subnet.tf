# 윤지 대역대
# 10.0.11.0/24 - 94102178-IaC-TFT-web-subnet-privatea
# 10.0.12.0/24 - 94102178-IaC-TFT-was-subnet-privatea
# 10.0.13.0/24 - 94102178-IaC-TFT-db-subnet-privatea
# 10.0.110.0/24 - 94102178-IaC-TFT-web-subnet-privatec
# 10.0.111.0/24 - 94102178-IaC-TFT-was-subnet-privatec
# 10.0.112.0/24 - 94102178-IaC-TFT-db-subnet-privatec


# WEB Private Subnet A
resource "aws_subnet" "web_private_a" {
    vpc_id = aws_vpc.vpc.id
    availability_zone = "ap-northeast-2a"
    cidr_block = "10.0.11.0/24"
    tags = {
        Name = "${var.id_num}-IaC-TFT-web-subnet-privatea"
    }
}

# WEB Private Subnet C
resource "aws_subnet" "web_private_c" {
    vpc_id = aws_vpc.vpc.id
    availability_zone = "ap-northeast-2c"
    cidr_block = "10.0.110.0/24"
    tags = {
        Name = "${var.id_num}-IaC-TFT-web-subnet-privatec"
    }
}

# WAS Private Subnet A
resource "aws_subnet" "was_private_a" {
    vpc_id = aws_vpc.vpc.id
    availability_zone = "ap-northeast-2a"
    cidr_block = "10.0.12.0/24"
    tags = {
        Name = "${var.id_num}-IaC-TFT-was-subnet-privatea"
    }
}

# WAS Private Subnet C
resource "aws_subnet" "was_private_c" {
    vpc_id = aws_vpc.vpc.id
    availability_zone = "ap-northeast-2c"
    cidr_block = "10.0.120.0/24"
    tags = {
        Name = "${var.id_num}-IaC-TFT-was-subnet-privatec"
    }
}

# DB Private Subnet A
resource "aws_subnet" "db_private_a" {
    vpc_id = aws_vpc.vpc.id
    availability_zone = "ap-northeast-2a"
    cidr_block = "10.0.13.0/24"
    tags = {
        Name = "${var.id_num}-IaC-TFT-db-subnet-privatea"
    }
}

# DB Private Subnet C
resource "aws_subnet" "db_private_c" {
    vpc_id = aws_vpc.vpc.id
    availability_zone = "ap-northeast-2c"
    cidr_block = "10.0.130.0/24"
    tags = {
        Name = "${var.id_num}-IaC-TFT-db-subnet-privatec"
    }
}

# WEB Private Routing Table
resource "aws_route_table" "web_private_rt" {
    vpc_id = aws_vpc.vpc.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_nat_gateway.nat_gw.id
    }
    tags = {
        Name = "${var.id_num}-IaC-TFT-web-rt-private"
    }
}

# WAS Private Routing Table
resource "aws_route_table" "was_private_rt" {
    vpc_id = aws_vpc.vpc.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_nat_gateway.nat_gw.id
    }
    tags = {
        Name = "${var.id_num}-IaC-TFT-was-rt-private"
    }
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
