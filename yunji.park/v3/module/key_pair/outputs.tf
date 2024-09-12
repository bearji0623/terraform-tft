output "output_key_id" {
    value = aws_key_pair.key.id
}

output "output_key_file_id" {
    value = local_file.ssh_key.id
}