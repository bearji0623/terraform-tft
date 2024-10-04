### Bastion EC2 SG Output ###
output "bastion_sg_id" {
  value = aws_security_group.dev_juno_sg_bastion_ec2.id
}

### Public WEB ALB SG Output ###
output "webalb_sg_id" {
  value = aws_security_group.dev_juno_sg_webalb_pub.id
}

### Private WEB EC2 SG Output ###
output "web_ec2_sg_id" {
  value = aws_security_group.dev_juno_sg_web_ec2.id
}

### Private WAS NLB SG Output ###
output "wasnlb_sg_id" {
  value = aws_security_group.dev_juno_sg_wasnlb_pri.id
}

### Private WAS EC2 SG Output ###
output "was_ec2_sg_id" {
  value = aws_security_group.dev_juno_sg_was_ec2.id
}

### Private RDS SG Output ###
output "rds_sg_id" {
  value = aws_security_group.dev_juno_sg_rds.id
}
