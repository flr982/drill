variable "project" {
  description = "Project name"
  type = string
}

variable "env" {
  description = "Environment name"
  type = string
}

variable "bucket_name" {
  description = "Name of the bucket to be created"
  type = string
}

variable "common_tags" {
  description = "Map of common tags"
  type        = map(any)
}
