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

  ami                = var.ami
  server_count       = var.server_count
  project            = var.project
  region             = var.region
  env                = var.env
  server_name_prefix = var.server_name_prefix
  key_name           = var.key_name
  subnet_id          = data.terraform_remote_state.vpc.outputs.public_subnet_ids[0]
  allow_ip           = var.allow_ip
  server_port        = var.server_port
  vpc_id             = data.terraform_remote_state.vpc.outputs.vpc_id
  common_tags        = local.common_tags
}



terraform {
  backend "s3" {
    bucket  = "drill-tf-states"
    key     = "ec2/terraform.tfstate"
    region  = "eu-central-1"
    encrypt = true
  }
}
