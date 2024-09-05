output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.vpc.vpc_id
}

output "public_subnets" {
  description = "Public subnets for the VPC"
  value       = module.vpc.public_subnets
}

output "private_subnets" {
  description = "Private subnets for the VPC"
  value       = module.vpc.private_subnets
}
