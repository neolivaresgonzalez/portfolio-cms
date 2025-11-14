# Route53 Hosted Zone for root domain
resource "aws_route53_zone" "root" {
  name = var.root_domain
}

# DNS A Record for CMS subdomain
resource "aws_route53_record" "cms_a" {
  zone_id = aws_route53_zone.root.zone_id
  name    = local.cms_fqdn
  type    = "A"
  ttl     = 300
  records = [aws_lightsail_static_ip.this.ip_address]
}


