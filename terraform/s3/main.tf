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

resource "aws_s3_bucket" "b" {
  bucket = var.bucket_name

  tags = local.common_tags
}

resource "aws_s3_bucket_versioning" "b" {
  bucket = aws_s3_bucket.b.id
  versioning_configuration {
    status = "Enabled"
  }
}

# resource "aws_s3_bucket_acl" "example" {
#   bucket = aws_s3_bucket.b.id
#   acl    = "private"
# }

resource "aws_s3_bucket_public_access_block" "example" {
  bucket = aws_s3_bucket.b.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_policy" "b" {
  bucket = aws_s3_bucket.b.id

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "allowaccess",
      "Action": [
        "s3:GetObject"
      ],
      "Effect": "Deny",
      "Resource": "arn:aws:s3:::metr0polis-1/*",
      "Principal": "*"
    }
  ]
}
POLICY
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
