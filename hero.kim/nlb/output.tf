output "nlb_arn" {
  description = "The ARN of the ALB"
  value       = aws_lb.nlb.arn
}

output "nlb_dns_name" {
  description = "The DNS name of the ALB"
  value       = aws_lb.nlb.dns_name
}

output "nlb_zone_id" {
  description = "The Zone id of the ALB"
  value       = aws_lb.nlb.zone_id
}