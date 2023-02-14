provider "aws" {
  region = "eu-central-1"
}


locals {
  common_tags = {
    Project     = var.project
    Environment = var.env
    CreatedBy   = "Terraform"
  }
}

#
# Code goes here
#

terraform {
  backend "s3" {
    bucket = "terraform-study-state"
    key    = "ec2/terraform.tfstate" # UPDATE THE KEY!!
    region = "eu-central-1"

    # dynamodb_table = "terraform_study_locks"
    encrypt = true
  }
}
