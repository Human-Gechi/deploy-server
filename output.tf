# Output variables for script
output "my_access_key_id" {
  value = aws_iam_access_key.Developer_access_key.id
}

output "my_secret_access_key" {
  value     = aws_iam_access_key.Developer_access_key.secret
  sensitive = true
}

output "private_key_pem" {
  value     = tls_private_key.ec2_key.private_key_pem
  sensitive = true
}

output "instance_public_ip" {
  value = aws_instance.web-server
}