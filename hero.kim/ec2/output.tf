output "bastion_public_ip" {
  description = "The public IP of the Bastion host"
  value       = module.ec2_instance.public_ip
}

output "web_ip" {
  description = "The public IP of the Bastion host"
  value       = module.ec2_instance1.private_ip
}
output "web1_ip" {
  description = "The public IP of the Bastion host"
  value       = module.ec2_instance2.private_ip
}

output "was_ip" {
  description = "The public IP of the Bastion host"
  value       = module.ec2_instance3.private_ip
}

output "was1_ip" {
  description = "The public IP of the Bastion host"
  value       = module.ec2_instance4.private_ip
}

output "ec2_instance1_id" {
  description = "The ID of the WEB EC2 instance"
  value       = module.ec2_instance1.id
}

output "ec2_instance2_id" {
  description = "The ID of the WEB EC2 instance"
  value       = module.ec2_instance2.id
}