output "was_ec2_id" {
  description = "WAS EC2 IDs"
  value       = {for idx, instance in aws_instance.dev_juno_ec2 : idx => instance.id}
}
