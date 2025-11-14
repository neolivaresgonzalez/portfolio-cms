# IP pública del CMS
output "public_ip" {
  value       = aws_lightsail_static_ip.this.ip_address
  description = "IP pública del CMS"
}

# Comando sugerido de SSH
output "ssh_command" {
  value       = "ssh -i ~/.ssh/portfolio-cms ubuntu@${aws_lightsail_static_ip.this.ip_address}"
  description = "Comando sugerido de SSH"
}

# Name servers de Route53
output "route53_name_servers" {
  value       = aws_route53_zone.root.name_servers
  description = "Name servers de Route53 (configúralos en tu registrador)"
}

# URL del CMS
output "cms_url" {
  value       = "https://${local.cms_fqdn}"
}