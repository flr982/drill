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


resource "aws_instance" "bastion" {
  ami                         = var.ami
  instance_type               = var.instance_type
  key_name                    = var.key_name
  vpc_security_group_ids      = [aws_security_group.bastion.id]
  subnet_id                   = data.terraform_remote_state.vpc.outputs.public_subnet_ids[0]
  associate_public_ip_address = true

  tags = merge(
    local.common_tags,
    {
      Name = "bastion"
    }
  )
}


resource "aws_security_group" "bastion" {
  name   = "${var.project}-bastion-sg-${var.env}"
  vpc_id = data.terraform_remote_state.vpc.outputs.vpc_id

  tags = merge(
    local.common_tags,
    {
      Name = "${var.project}-bastion-${var.env}"
    }
  )

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.allow_ip]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  lifecycle {
    create_before_destroy = true
  }
}


terraform {
  backend "s3" {
    bucket  = "drill-tf-states"
    key     = "bastion/terraform.tfstate"
    region  = "eu-central-1"
    encrypt = true
  }
}
