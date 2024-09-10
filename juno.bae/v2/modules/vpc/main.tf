#### VPC 생성 ####
resource "aws_vpc" "juno_vpc" {
  cidr_block       = var.vpc_cidr
  enable_dns_hostnames = true

  tags = {
    Name = "${var.env}-${var.project}-VPC"
  }
}