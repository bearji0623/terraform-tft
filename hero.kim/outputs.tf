output "bastion_public_ip" {
  description = "The public IP of the Bastion host"
  value       = module.ec2.bastion_public_ip
}

output "web_ip" {
  description = "The public IP of the Bastion host"
  value       = module.ec2.web_ip
}

output "was_ip" {
  description = "The public IP of the Bastion host"
  value       = module.ec2.was_ip
}