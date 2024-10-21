resource "aws_s3_bucket" "this" {
  bucket        = var.bucket_name
  force_destroy = true

  tags = var.tags
}

resource "aws_s3_bucket_ownership_controls" "bucket_ownership" {
  bucket = aws_s3_bucket.this.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_acl" "bucket_acl" {
  bucket     = aws_s3_bucket.this.id
  acl        = var.acl
  depends_on = [aws_s3_bucket_ownership_controls.bucket_ownership]
}

resource "aws_s3_bucket_versioning" "bucket_versioning" {
  count = var.enable_versioning ? 1 : 0

  bucket = aws_s3_bucket.this.id
  versioning_configuration {
    status     = var.versioning_status
    mfa_delete = var.mfa_delete
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "sse" {
  bucket = aws_s3_bucket.this.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = var.sse_algorithm
      kms_master_key_id = var.kms_master_key_id
    }
  }
}

resource "aws_s3_bucket_public_access_block" "this" {
  bucket = aws_s3_bucket.this.id

  block_public_acls       = var.block_public_acls
  block_public_policy     = var.block_public_policy
  ignore_public_acls      = var.ignore_public_acls
  restrict_public_buckets = var.restrict_public_buckets
}

resource "aws_s3_bucket_policy" "flow_log_s3_policy" {
  count = var.attach_policy ? 1 : 0

  bucket = aws_s3_bucket.this.id
  policy = var.policy

}
