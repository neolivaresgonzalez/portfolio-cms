resource "random_id" "media_bucket_suffix" {
  byte_length = 4
}

resource "aws_s3_bucket" "media_bucket" {
  bucket = "${var.name_prefix}-media-${random_id.media_bucket_suffix.hex}"
  
  force_destroy = false # Prevent accidental deletion of production data

  tags = {
    Name        = "${var.name_prefix}-media"
    Environment = var.environment
  }
}

# Block all public access by default (files served via Signed URLs or direct if ACL allowed, Strapi usually handles public READ)
# Strapi S3 provider usually default to ACL "public-read" for assets so they can be viewed.
# We will enable ACLs and allow public read for objects.
resource "aws_s3_bucket_ownership_controls" "media_ownership" {
  bucket = aws_s3_bucket.media_bucket.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_public_access_block" "media_public_access" {
  bucket = aws_s3_bucket.media_bucket.id

  block_public_acls       = false
  ignore_public_acls      = false
  block_public_policy     = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_acl" "media_acl" {
  depends_on = [
    aws_s3_bucket_ownership_controls.media_ownership,
    aws_s3_bucket_public_access_block.media_public_access,
  ]

  bucket = aws_s3_bucket.media_bucket.id
  acl    = "public-read"
}


