
resource "aws_s3_bucket" "artifacts" {
  bucket_prefix = "kamyar-capstone-artifacts-"
  force_destroy = false
  tags = { Name = "kamyar-Capstone-Artifacts-S3" }
}
resource "aws_s3_bucket_public_access_block" "artifacts" {
  bucket = aws_s3_bucket.artifacts.id
  block_public_acls = true
  block_public_policy = true
  ignore_public_acls = true
  restrict_public_buckets = true
}

