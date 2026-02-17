# -----------------------------------------------------------------------------
# EC2 INSTANCE (CMS Hosting) - Replacing Lightsail for Free Tier
# -----------------------------------------------------------------------------

# Local values moved from lightsail.tf
locals {
  instance_name = "${var.name_prefix}-prod"
  cms_fqdn      = "${var.cms_subdomain}.${var.root_domain}"
}

# Data source for Ubuntu 22.04 LTS AMI
data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# Key Pair for EC2 - Managed manually/externally to avoid import issues
# resource "aws_key_pair" "cms_key" {
#   key_name   = "${var.name_prefix}-ec2-key"
#   public_key = file(var.public_key_path)
# }

# Security Group
resource "aws_security_group" "cms_sg" {
  name        = "${var.name_prefix}-sg"
  description = "Allow inbound traffic for CMS"

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Strapi API"
    from_port   = 1337
    to_port     = 1337
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.name_prefix}-sg"
  }
}

# EC2 Instance
resource "aws_instance" "cms" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro" # Free Tier eligible

  key_name        = "${var.name_prefix}-ec2-key" # Hardcoded to match existing key
  security_groups = [aws_security_group.cms_sg.name]

  root_block_device {
    volume_size = 20 # 20GB is within Free Tier (up to 30GB)
    volume_type = "gp3"
  }

  # User Data script to install Node.js 20, PM2, and dependencies
  user_data = <<-EOF
              #!/bin/bash
              apt-get update
              apt-get install -y ca-certificates curl gnupg git

              # Install Node.js 20
              mkdir -p /etc/apt/keyrings
              curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg
              echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_20.x nodistro main" | tee /etc/apt/sources.list.d/nodesource.list
              apt-get update
              apt-get install -y nodejs build-essential

              # Install PM2
              npm install -g pm2

              # Create directory and set permissions
              mkdir -p /opt/portfolio-cms
              chown -R ubuntu:ubuntu /opt/portfolio-cms
              EOF

  tags = {
    Name = "${var.name_prefix}-ec2"
  }
}
