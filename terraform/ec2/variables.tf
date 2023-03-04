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
