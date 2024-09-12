output "output_vpc_id" {
    value = aws_vpc.vpc.id
}

output "output_public_subnet_a_id" {
    value = aws_subnet.public_a.id
}

output "output_public_subnet_c_id" {
    value = aws_subnet.public_c.id
}

output "output_web_private_subnet_a_id" {
    value = aws_subnet.web_private_a.id
}

output "output_web_private_subnet_c_id" {
    value = aws_subnet.web_private_c.id
}

output "output_was_private_subnet_a_id" {
    value = aws_subnet.was_private_a.id
}

output "output_was_private_subnet_c_id" {
    value = aws_subnet.was_private_c.id
}

output "output_db_private_subnet_a_id" {
    value = aws_subnet.db_private_a.id
}

output "output_db_private_subnet_c_id" {
    value = aws_subnet.db_private_c.id
}

output "output_igw_id" {
    value = aws_internet_gateway.igw.id
}

output "output_nat_eip_id" {
    value = aws_eip.nat_eip.id
}

output "output_nat_gw_id" {
    value = aws_nat_gateway.nat_gw.id
}

output "output_public_rt_id" {
    value = aws_route_table.public_rt.id
}

output "output_web_private_rt_id" {
    value = aws_route_table.web_private_rt.id
}

output "output_was_private_rt_id" {
    value = aws_route_table.was_private_rt.id
}

output "output_db_private_rt_id" {
    value = aws_route_table.db_private_rt.id
}