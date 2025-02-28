variable "region" {
  description = "Region where to depoloy the project"
}

variable "project" {
  description = "Project name"
}

variable "env" {
  description = "Environment name"
}

variable "ami" {
  type        = string
  description = "The ID of the AMI to use"
}

variable "instance_type" {
  description = "The EC2 instance type"
  default     = "t3.micro" # General purpose, 2vCPU, 0.5GB
}

variable "key_name" {
  description = "ssh key pair name"
}

# variable "subnet_id" {
#   description = "The ID of the public subnet to be used by the EC2 instance"
# }

# variable "vpc_id" {
#   description = "The ID of the VPC to be used by the security group"
# }

variable "allow_ip" {
  description = "The IP (range) allowed into the SG"
  default     = "0.0.0.0/0"
}
