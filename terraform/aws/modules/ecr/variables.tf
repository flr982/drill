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

variable "common_tags" {
  description = "Map of common tags"
  type        = map(any)
}
