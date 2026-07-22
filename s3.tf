resource "aws_s3_bucket" "web_server_bucket" {
  bucket = var.bucket_name
  tags   = merge(local.common_tags)
}

resource "aws_s3_bucket_versioning" "bucket_versioning" {
  bucket = aws_s3_bucket.web_server_bucket.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_account_public_access_block" "bucket_restrictions" {
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
