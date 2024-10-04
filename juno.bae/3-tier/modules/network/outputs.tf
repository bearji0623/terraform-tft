output "vpc_id" {
    value = aws_vpc.dev_juno_vpc.id
}

output "subnet_id" {
  value = {
    public_subnet_a = aws_subnet.dev_juno_subnet["public_subnet_a"].id,
    public_subnet_c = aws_subnet.dev_juno_subnet["public_subnet_c"].id,
    web_subnet_a    = aws_subnet.dev_juno_subnet["web_subnet_a"].id,
    web_subnet_c    = aws_subnet.dev_juno_subnet["web_subnet_c"].id,
    was_subnet_a    = aws_subnet.dev_juno_subnet["was_subnet_a"].id,
    was_subnet_c    = aws_subnet.dev_juno_subnet["was_subnet_c"].id,
    db_subnet_a     = aws_subnet.dev_juno_subnet["db_subnet_a"].id,
    db_subnet_c     = aws_subnet.dev_juno_subnet["db_subnet_c"].id
  }
}


