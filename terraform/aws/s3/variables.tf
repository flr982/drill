variable "project" {
  description = "Project name"
  type        = string
}

variable "region" {
  description = "The AWS region to use"
  type        = string
}

variable "env" {
  description = "Environment name"
  type        = string
}

variable "bucket_name" {
  description = "Name of the bucket to be created"
  type        = string
}
