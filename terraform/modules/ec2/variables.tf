variable "region" {
  description = "Region where to depoloy the project"
}

variable "project" {
  description = "Project name"
}

variable "env" {
  description = "Environment name"
}

variable "server_name_prefix" {
  description = "EC2 instances server name prefix"
  default     = "hammer"
}

variable "server_count" {
  description = "Number of EC2 instances"
  type        = number
  default     = 1
}

variable "ami" {
  type        = map(any)
  description = "The ID of the AMI to use"
  default = {
    eu-central-1 = "ami-0d41436f676752240" # Ubuntu Server 22.04 LTS (HVM), SSD Volume Type, x86
    eu-west-2    = "ami-0b88982d9d03f32a5"
  }
}

variable "type" {
  description = "The EC2 instance type"
  default     = "t3.micro" # General purpose, 2vCPU, 0.5GB
}

variable "key_name" {
  description = "ssh key pair name"
}

variable "subnet_id" {
  description = "The ID of the public subnet to be used by the EC2 instance"
}

variable "vpc_id" {
  description = "The ID of the VPC to be used by the security group"
}

variable "server_port" {
  description = "The ingress port"
  type        = number
}

variable "allow_ip" {
  description = "The IP (range) allowed into the SG"
  default     = "0.0.0.0/0"
}

variable "common_tags" {
  description = "Map of common tags"
  type        = map(any)
}
