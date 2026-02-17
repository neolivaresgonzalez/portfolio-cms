# AWS region variable
variable "aws_region" {
  description = "AWS región for Lightsail / Route53"
  type        = string
  default     = "ca-central-1"
}

# Resource name prefix
variable "name_prefix" {
  type        = string
  default     = "portfolio-cms"
  description = "Prefix for resources names"
}

# SSH Key Pair variable
variable "public_key_path" {
  type        = string
  description = "Path of the SSH public key (ej: ~/.ssh/portfolio-cms.pub)"
}

# Domain variables
variable "root_domain" {
  type        = string
  default     = "nolivares.com"
  description = "Dominio raíz"
}

# Install script path variable
variable "install_script_path" {
  type        = string
  description = "Path to the install script for the Lightsail instance"
}

# Subdomain for CMS
variable "cms_subdomain" {
  type        = string
  default     = "cms"
  description = "Subdominio para el CMS (cms.neolivaresgonzalez.com)"
}

# Environment variable
variable "environment" {
  type        = string
  default     = "production"
  description = "Deployment environment (e.g., production, staging)"
}

# Owner variable
variable "owner" {
  type        = string
  default     = "Nicolas Eduardo Olivares Gonzalez"
  description = "Owner of the infrastructure"
}
