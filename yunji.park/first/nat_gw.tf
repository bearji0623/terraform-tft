# NAT Gateway
resource "aws_nat_gateway" "nat_gw" {
    allocation_id = "eipalloc-0b5b8899c3f94b53b"
    subnet_id = aws_subnet.public_a.id

    tags = {
        Name = "${var.id_num}-IaC-TFT-ngw"
    }
}

