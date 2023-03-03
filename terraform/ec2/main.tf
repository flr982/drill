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

data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket = "drill-tf-states"
    key    = "vpc/terraform.tfstate"
    region = "eu-central-1"
  }
}

module "ec2" {
  source = "../modules/ec2"

  server_count       = var.server_count
  project            = var.project
  region             = var.region
  env                = var.env
  server_name_prefix = var.server_name_prefix
  key_name           = var.key_name
  subnet_id          = data.terraform_remote_state.vpc.outputs.public_subtnet_ids[0] #"subnet-0f893e2306d7470dd"
  allow_ip           = var.allow_ip
  server_port        = var.server_port
  vpc_id             = data.terraform_remote_state.vpc.outputs.vpc_id #"vpc-05f492e7a7d82b9b3"
  common_tags        = local.common_tags
}



terraform {
  backend "s3" {
    # bucket = "terraform-study-state"
    bucket = "drill-tf-states"
    key    = "ec2/terraform.tfstate"
    region = "eu-central-1"

    # dynamodb_table = "terraform_study_locks"
    encrypt = true
  }
}
