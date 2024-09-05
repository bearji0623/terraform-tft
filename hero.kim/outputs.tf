output "bastion_public_ip" {
  description = "The public IP of the Bastion host"
  value       = module.ec2.bastion_public_ip
}

output "web_private_ip" {
  description = "The public IP of the Bastion host"
  value       = module.ec2.web_private_ip
}