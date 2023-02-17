variable "project" {
  description = "The project name"
  type        = string
}

variable "region" {
  description = "The AWS region to use"
  type        = string
}

variable "env" {
  description = "The environment name"
  type        = string
}

variable "main_vpc_cidr" {
  description = "The CIRD used by this VPC"
  type        = string
}

variable "public_subnet_cidrs" {
  description = "The CIRDs used by the public subnets"
  type        = map(any)
}

variable "private_subnet_cidrs" {
  description = "The CIRDs used by the private subnets"
  type        = map(any)
}
