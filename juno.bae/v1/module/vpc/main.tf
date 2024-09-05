#### VPC 생성 ####
resource "aws_vpc" "juno_iac_tft_vpc" {
  cidr_block       = var.vpc_cidr
  enable_dns_hostnames = true

  tags = {
    Name = "94102047-JUNO-IaC-TFT-VPC"
  }
}


### Public 서브넷 생성 ###
resource "aws_subnet" "juno_pub_sub" {
    count = 2
    vpc_id = aws_vpc.juno_iac_tft_vpc.id
    cidr_block = var.pub_sub_cidr[count.index]
    availability_zone = element(var.az_list, count.index)
    
    tags = {
      Name = "JUNO_PUB_SUB_${local.alphabet[count.index]}"
  }
}

### Private 서브넷 WEB 생성 ###
resource "aws_subnet" "juno_pri_sub_web" {
    count = 2
    vpc_id = aws_vpc.juno_iac_tft_vpc.id
    cidr_block = var.pri_sub_web_cidr[count.index]
    availability_zone = element(var.az_list, count.index)
    
    tags = {
      Name = "JUNO_PRI_SUB_WEB_${local.alphabet[count.index]}"
  }
}

### Private 서브넷 WAS 생성 ###
resource "aws_subnet" "juno_pri_sub_was" {
    count = 2
    vpc_id = aws_vpc.juno_iac_tft_vpc.id
    cidr_block = var.pri_sub_was_cidr[count.index]
    availability_zone = element(var.az_list, count.index)
    
    tags = {
      Name = "JUNO_PRI_SUB_WAS_${local.alphabet[count.index]}"
  }
}

### Private 서브넷 DB 생성 ###
resource "aws_subnet" "juno_pri_sub_db" {
    count = 2
    vpc_id = aws_vpc.juno_iac_tft_vpc.id
    cidr_block = var.pri_sub_db_cidr[count.index]
    availability_zone = element(var.az_list, count.index)
    
    tags = {
      Name = "JUNO_PRI_SUB_DB_${local.alphabet[count.index]}"
  }
}


### IGW 생성 후 VPC 연결###
resource "aws_internet_gateway" "juno_igw" {
  vpc_id     = aws_vpc.juno_iac_tft_vpc.id

  tags = {
    Name = "94102047-IaC-TFT-IGW"
  }
}

### NGW 생성 ###
resource "aws_nat_gateway" "juno_ngw" {
  # allocation_id = data.aws_eip.juno_ngw_eip.id
  allocation_id = "eipalloc-0d1afe7a8b1d6548c"
  subnet_id     = aws_subnet.juno_pub_sub.*.id[0]

  tags = {
    Name = "94102047-JUNO-NGW"
  }
}


### Public 라우팅 테이블 생성 ###
resource "aws_route_table" "juno_pub_rtb" {
  vpc_id     = aws_vpc.juno_iac_tft_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.juno_igw.id
  }

  tags = {
    Name = "JUNO_PUB_RTB"
  }
}

### PRIVATE SUBNET 라우팅 테이블 생성 ###
resource "aws_route_table" "juno_pri_rtb" {
  vpc_id     = aws_vpc.juno_iac_tft_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.juno_ngw.id
  }

  tags = {
    Name = "JUNO_PRI_RTB"
  }
}


### Public 라우팅 테이블 연결 - PUB ###
resource "aws_route_table_association" "juno_pub_sub_asso" {
    count = 2
    subnet_id = aws_subnet.juno_pub_sub.*.id[count.index]
    route_table_id = aws_route_table.juno_pub_rtb.id
}

### Private 라우팅 테이블 연결 - WEB ###
resource "aws_route_table_association" "juno_pri_sub_web_asso" {
    count = 2
    subnet_id = aws_subnet.juno_pri_sub_web.*.id[count.index]
    route_table_id = aws_route_table.juno_pri_rtb.id
}

### Private 라우팅 테이블 연결 - WAS ###
resource "aws_route_table_association" "juno_pri_sub_was_asso" {
    count = 2
    subnet_id = aws_subnet.juno_pri_sub_was.*.id[count.index]
    route_table_id = aws_route_table.juno_pri_rtb.id
}



### S3 Gateway Endpoint 생성 ###
resource "aws_vpc_endpoint" "juno-vpcep-s3" {
  vpc_id            = aws_vpc.juno_iac_tft_vpc.id
  service_name      = "com.amazonaws.ap-northeast-2.s3"
  vpc_endpoint_type = "Gateway"
  route_table_ids = [aws_route_table.juno_pub_rtb.id, aws_route_table.juno_pri_rtb.id]
  
    tags = {
    Name = "JUNO-VPCE-S3"
  }
}