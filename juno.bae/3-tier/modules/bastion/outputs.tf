### Bastion EC2 Output ###
output "bastion_instance_id" {
  value = aws_instance.dev_juno_ec2_bastion.id
}
