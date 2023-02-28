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
  source = "../modules/s3"

  project     = var.project
  env         = var.env
  bucket_name = var.bucket_name
  common_tags = local.common_tags
}



terraform {
  backend "s3" {
    bucket = "terraform-study-state"
    key    = "s3/terraform.tfstate"
    region = "eu-central-1"

    # dynamodb_table = "terraform_study_locks"
    encrypt = true
  }
}
