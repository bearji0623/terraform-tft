#### VPC 생성 ####
resource "aws_vpc" "dev_juno_vpc" {
  cidr_block       = var.vpc_cidr
  enable_dns_hostnames = var.enable_dns_hostnames

  tags = {
    Name = "${var.env}-${var.project}-VPC"

  }
}

### 서브넷 생성 ###
resource "aws_subnet" "dev_juno_subnet" {
  for_each = var.subnet  # subnet 변수로부터 CIDR 및 AZ 정보 전달

  vpc_id            = aws_vpc.dev_juno_vpc.id
  cidr_block        = each.value.cidr  # 각 서브넷의 CIDR 블록
  availability_zone = each.value.az    # 각 서브넷의 가용 영역

  tags = {
    Name = "${var.env}-${var.project}-${each.value.name}"  # 서브넷 이름은 고정
  }
}

### IGW 생성 ###
resource "aws_internet_gateway" "dev_juno_igw" {
  vpc_id     = aws_vpc.dev_juno_vpc.id

  tags = {
    Name = "${var.env}-${var.project}-IGW"
  }
}

### EIP 생성 ###
resource "aws_eip" "dev_juno_eip_ngw" {

  tags = {
    Name = "${var.env}-${var.project}-EIP-NGW"
  }
}
  
### NGW 생성 ###
resource "aws_nat_gateway" "dev_juno_ngw" {
  allocation_id = aws_eip.dev_juno_eip_ngw.id
  subnet_id     = aws_subnet.dev_juno_subnet["public_subnet_a"].id

  tags = {
    Name = "${var.env}-${var.project}-NGW"
  }
}

### 라우팅 테이블 생성 ###
resource "aws_route_table" "dev_juno_rtb" {
  for_each = var.route_tables

  vpc_id = aws_vpc.dev_juno_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    # 퍼블릭일 경우 인터넷 게이트웨이, 프라이빗일 경우 NAT 게이트웨이 사용
    gateway_id      = each.value.is_public ? aws_internet_gateway.dev_juno_igw.id : null
    nat_gateway_id  = !each.value.is_public ? aws_nat_gateway.dev_juno_ngw.id : null
  }

  tags = {
    Name = "${var.env}-${var.project}-${each.value.name}"
  }
}

### 서브넷과 라우팅 테이블 연결 ###
resource "aws_route_table_association" "dev_juno_rtb_asso" {
  for_each = var.subnet

  subnet_id      = aws_subnet.dev_juno_subnet[each.key].id
  route_table_id = aws_route_table.dev_juno_rtb[each.value.route_table].id
}

### S3 Gateway Endpoint 생성 ###
resource "aws_vpc_endpoint" "dev_juno_gw_vpcep_s3" {
  vpc_id            = aws_vpc.dev_juno_vpc.id
  service_name      = var.endpoint_service_name
  vpc_endpoint_type = var.endpoint_type
    route_table_ids = [
    aws_route_table.dev_juno_rtb["web_rt"].id,  # WEB 서브넷 라우팅 테이블
    aws_route_table.dev_juno_rtb["was_rt"].id   # WAS 서브넷 라우팅 테이블
  ]
  
  tags = {
    Name = "${var.env}-${var.project}-VPCE-S3"
  }
}