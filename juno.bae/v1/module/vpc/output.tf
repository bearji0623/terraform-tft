output "vpc_id" {
    value = aws_vpc.juno_iac_tft_vpc.id
}

output "pub_sub_id" {
    value = aws_subnet.juno_pub_sub.*.id
}

output "pri_sub_web_id" {
    value = aws_subnet.juno_pri_sub_web.*.id
}

output "pri_sub_was_id" {
    value = aws_subnet.juno_pri_sub_was.*.id
}

output "pri_sub_db_id" {
    value = aws_subnet.juno_pri_sub_db.*.id
}
