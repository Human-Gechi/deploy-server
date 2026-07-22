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
variable "password_lenght" {
  description = "Length of the generated password"
  type        = number
  default     = 16
}

variable "managed_by" {
  description = "IAC management"
  type        = string
  default     = "Terraform"
}