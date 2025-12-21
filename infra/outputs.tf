output "cms_public_ip" {
  description = "Public IP of the CMS EC2 instance"
  value       = aws_instance.cms.public_ip
}

output "cms_url" {
  description = "URL for the CMS"
  value       = "http://${local.cms_fqdn}"
}