terraform {
    required_version = ">= 1.6.0"

    backend "s3" {
        bucket = "tfstate-portfolio-cms-neolivaresgonzalez"
        key = "portfolio-cms/terraform.tfstate"
        region = "ca-central-1"
    }

    required_providers {
        aws = {
            source = "hashicorp/aws"
            version = "~> 5.0"
        }
    } 
}

provider "aws" {
    region = var.aws_region
}