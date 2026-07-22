# Terraform backend

terraform {
  backend "s3" {
    bucket       = "ogechukwu-web-server-bucket-hug2026"
    key          = "prod/terraform.tfstate"
    region       = "eu-north-1"
    use_lockfile = true
  }

}