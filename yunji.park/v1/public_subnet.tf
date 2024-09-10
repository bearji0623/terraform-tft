# Public Subnet
resource "aws_subnet" "public_a" {
    vpc_id = aws_vpc.vpc.id
    availability_zone = "ap-northeast-2a"
    cidr_block = "10.0.0.0/25"
    tags = {
        Name = "${var.id_num}-IaC-TFT-subnet-publica"
    }
    map_public_ip_on_launch = true
}

resource "aws_subnet" "public_c" {
    vpc_id = aws_vpc.vpc.id
    availability_zone = "ap-northeast-2c"
    cidr_block = "10.0.0.128/25"
    tags = {
        Name = "${var.id_num}-IaC-TFT-subnet-publicc"
    }
    map_public_ip_on_launch = true
}

# Public Routing Table
resource "aws_route_table" "public_rt" {
    vpc_id = aws_vpc.vpc.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw.id
    }
    tags = {
        Name = "${var.id_num}-IaC-TFT-rt-public"
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
