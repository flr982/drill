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


module "ecr" {
  source = "../modules/ecr"

  project            = var.project
  region             = var.region
  env                = var.env
  common_tags        = local.common_tags
}


terraform {
  backend "s3" {
    bucket = "drill-tf-states"
    key    = "ecr/terraform.tfstate"
    region = "eu-central-1"

    # dynamodb_table = "terraform_study_locks"
    encrypt = true
  }
}
