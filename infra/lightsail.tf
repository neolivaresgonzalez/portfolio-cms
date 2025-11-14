# Local values
locals {
  instance_name = "${var.name_prefix}-prod"
  cms_fqdn      = "${var.cms_subdomain}.${var.root_domain}"
}

# SSH Key Pair for Lightsail
resource "aws_lightsail_key_pair" "this" {
  name       = "${var.name_prefix}-key"
  public_key = file(var.public_key_path)
}

# Lightsail instance for CMS
resource "aws_lightsail_instance" "this" {
  name              = local.instance_name
  availability_zone = "${var.aws_region}a"
  blueprint_id      = "ubuntu_22_04"
  bundle_id         = "micro_2_0"
  key_pair_name     = aws_lightsail_key_pair.this.name

  user_data = <<-CLOUDINIT
              #!/bin/bash
              set -euo pipefail
              export DEBIAN_FRONTEND=noninteractive

              apt-get update -y
              apt-get install -y ca-certificates curl gnupg lsb-release

              # Docker
              install -m 0755 -d /etc/apt/keyrings
              curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
              chmod a+r /etc/apt/keyrings/docker.gpg

              echo \
                "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
                $(. /etc/os-release && echo $VERSION_CODENAME) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null

              apt-get update -y
              apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

              usermod -aG docker ubuntu

              mkdir -p /opt/portfolio-cms
              mkdir -p /opt/portfolio-cms/public/uploads
              mkdir -p /opt/portfolio-cms/data

              echo "${local.cms_fqdn}" > /etc/DOMAIN
              CLOUDINIT
}

# Open HTTP and HTTPS ports
resource "aws_lightsail_instance_public_ports" "this" {
  instance_name = aws_lightsail_instance.this.name

  # SSH
  port_info {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
  }

  # HTTP
  port_info {
    from_port = 80
    to_port   = 80
    protocol  = "tcp"
  }

  # HTTPS
  port_info {
    from_port = 443
    to_port   = 443
    protocol  = "tcp"
  }
}

# Static IP for Lightsail instance
resource "aws_lightsail_static_ip" "this" {
  name = "${var.name_prefix}-ip"
}

# Attach Static IP to Lightsail instance
resource "aws_lightsail_static_ip_attachment" "this" {
  static_ip_name = aws_lightsail_static_ip.this.name
  instance_name  = aws_lightsail_instance.this.name
}