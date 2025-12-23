output "cms_public_ip" {
  description = "Public IP of the CMS EC2 instance"
  value       = aws_instance.cms.public_ip
}

output "cms_url" {
  description = "URL for the CMS"
  value       = "http://${local.cms_fqdn}"
}

output "s3_bucket_name" {
  description = "Name of the S3 media bucket"
  value       = aws_s3_bucket.media_bucket.id
}
