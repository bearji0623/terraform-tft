output "bastion_public_ip" {
  description = "The public IP of the Bastion host"
  value       = module.ec2_instance.public_ip
}

output "web_private_ip" {
  description = "The public IP of the Bastion host"
  value       = module.ec2_instance1.private_ip
}

output "ec2_instance1_id" {
  description = "The ID of the WAS EC2 instance"
  value       = module.ec2_instance1.id
}