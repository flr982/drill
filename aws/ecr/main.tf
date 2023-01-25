provider "aws" {
  region = "eu-central-1"
}

locals {
  common_tags = {
    Project     = "api"
    Environment = "dev"
    CreatedBy   = "Terraform"
  }
}

resource "aws_ecr_repository" "ecr_api_repo" {
  name                 = "my_ecr_repo"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = local.common_tags
}


output "name" {
  value       = aws_ecr_repository.ecr_api_repo.name
  description = "the name"
}

output "url" {
  value       = aws_ecr_repository.ecr_api_repo.repository_url
  description = "the ecr repo url"
}

terraform {
  backend "s3" {
    bucket = "terraform-study-state"
    key    = "ecr/terraform.tfstate"
    region = "eu-central-1"

    # dynamodb_table = "terraform_study_locks"
    encrypt = true
  }
}