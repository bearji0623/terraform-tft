output "prod_policy_id" {
  description = "The policy ID for prod"
  value       = module.prod_policy.id
}

output "mfa_policy_id" {
  description = "The policy ID for prod"
  value       = module.mfa_policy.id
}