output "generated_password" {
  value     = random_password.dynamic_password.result
  sensitive = true

}

output "my_access_key_id" {
  value = aws_iam_access_key.Developer_access_key.id
}

output "my_secret_access_key" {
  value     = aws_iam_access_key.Developer_access_key.secret
  sensitive = true
}