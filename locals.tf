locals {
  common_tags = {
    Project     = var.project
    Team        = var.team
    Environment = var.environment
    ManagedBy   = var.managed_by
  }
}