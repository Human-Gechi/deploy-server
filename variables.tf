variable "region" {
  description = "Region for Infra"
  type        = string
  default     = "eu-north-1"

}
variable "team" {
  description = "Team in the Company"
  type        = string
  default     = "Developer Team"

}

variable "project" {
  description = "Project name"
  type        = string
  default     = "Web-server-deployment"
}

variable "environment" {
  description = "Environment"
  type        = string
  default     = "production"

}

variable "managed_by" {
  description = "IAC management"
  type        = string
  default     = "Terraform"
}

variable "bucket_name" {
  description = "Terraform state"
  type        = string
  default     = "ogechukwu-web-server-bucket-hug2026"
}