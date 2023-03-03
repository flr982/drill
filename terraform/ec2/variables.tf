variable "project" {
  description = "The project name"
  type        = string
  default     = "drill"
}

variable "region" {
  description = "The AWS region to use"
  type        = string
  default     = "eu-central-1"
}

variable "env" {
  description = "The environment name"
  type        = string
  default     = "dev"
}

variable "server_name_prefix" {
  description = "EC2 instances server name prefix"
}

variable "server_count" {
  description = "Number of EC2 instances"
  type        = number
}

variable "key_name" {
  description = "ssh key pair name"
}

variable "allow_ip" {
  description = "The IP (range) allowed into the SG"
}

variable "server_port" {
  description = "The ingress port"
  type        = number
}
