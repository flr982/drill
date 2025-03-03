project = "time"
region  = "eu-central-1"
env     = "dev"

# EC2
# ami              = "ami-06ee6255945a96aba" # Amazon Linux 2023 AMI 2023.6.20250218.2 x86_64 HVM kernel-6.1
ami              = "ami-06d99a92c80f4f5df" # ARM
instance_type    = "t4g.nano"
key_name         = "t470p-2020"
allow_ip         = "0.0.0.0/0"
min_size         = 1
max_size         = 3
desired_capacity = 1