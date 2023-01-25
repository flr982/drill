# variable "cluster_name" {
#   description = "The name to use to create the EclusterC2. Only alphanumeric characters and dash allowed (e.g. 'my-cluster')"
# }

variable "server_name" {
  description = "The name to use to create the EclusterC2. Only alphanumeric characters and dash allowed"
  default     = "hammer"
}

variable "ami" {
  description = "The ID of the AMI to use"
  default     = "ami-03e08697c325f02ab" # Ubuntu Server 22.04 LTS (HVM), SSD Volume Type, x86
}

variable "type" {
  description = "The EC2 instance type"
  default     = "t3.nano" # General purpose, 2vCPU, 0.5GB
}

variable "server_port" {
  description = "The ingress port"
  type        = number
  default     = 8080
}
