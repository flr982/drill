project = "drill"
region  = "eu-central-1"
env     = "dev"

# EC2
server_name_prefix = "bastion"
ami                = "ami-06ee6255945a96aba" # Amazon Linux 2023 AMI 2023.6.20250218.2 x86_64 HVM kernel-6.1
server_count       = 1
key_name           = "t470p-2020"
allow_ip           = "0.0.0.0/0"
server_port        = 10000 #8080