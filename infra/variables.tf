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
  default     = "neolivaresgonzalez.com"
  description = "Dominio raíz"
}

# Subdomain for CMS
variable "cms_subdomain" {
  type        = string
  default     = "cms"
  description = "Subdominio para el CMS (cms.neolivaresgonzalez.com)"
}