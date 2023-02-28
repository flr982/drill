provider "aws" {
  region = var.region
}


locals {
  common_tags = {
    Project     = var.project
    Environment = var.env
    CreatedBy   = "Terraform"
  }
}


module "vpc" {
  source = "./modules/vpc"

  project              = var.project
  region               = var.region
  env                  = var.env
  main_vpc_cidr        = var.main_vpc_cidr
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  common_tags          = local.common_tags
}



terraform {
  backend "s3" {
    bucket = "terraform-study-state"
    key    = "vpc/terraform.tfstate"
    region = "eu-central-1"

    # dynamodb_table = "terraform_study_locks"
    encrypt = true
  }
}

