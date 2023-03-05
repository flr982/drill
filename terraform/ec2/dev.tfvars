project = "drill"
region  = "eu-central-1"
env     = "dev"

# EC2
server_name_prefix = "hammer"
ami                = "ami-0c0933ae5caf0f5f9" # Amazon Linux
server_count       = 1
key_name           = "t470p-2020"
allow_ip           = "0.0.0.0/0"
server_port        = 10000 #8080