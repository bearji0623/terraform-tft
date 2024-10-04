output "web_ec2_id" {
  description = "WEB EC2 IDs"
  value       = {for idx, instance in aws_instance.dev_juno_ec2 : idx => instance.id}
}
