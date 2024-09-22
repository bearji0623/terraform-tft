output "bastion_sg_id" {
  description = "The ID of the Bastion security group"
  value       = aws_security_group.Bastion.id
}

output "web_sg_id" {
  description = "The ID of the WEB security group"
  value       = aws_security_group.WEB.id
}

output "alb_sg_id" {
  description = "The ID of the ALB security group"
  value       = aws_security_group.ALB.id
}

output "rds_sg_id" {
  description = "The ID of the RDS security group"
  value       = aws_security_group.RDS.id
}