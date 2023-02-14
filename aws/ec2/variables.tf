variable "region" {
  description = "Region where to depoloy the project"
  default     = "eu-west-2"
}

variable "project" {
  description = "Project name"
  default     = "drill"
}

variable "env" {
  description = "Environment name"
  default     = "dev"
}

variable "server_name" {
  description = "The name to use to create the EclusterC2. Only alphanumeric characters and dash allowed"
  default     = "hammer"
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
  default     = "t3.nano" # General purpose, 2vCPU, 0.5GB
}

variable "key_name" {
  description = "ssh key pair name"
  default     = "t470p-2020"
}

variable "server_port" {
  description = "The ingress port"
  type        = number
  default     = 8080
}

variable "allow_ip" {
  description = "The IP (range) allowed into the SG"
  default     = "82.78.48.81/32"
}
