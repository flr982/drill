project       = "drill"
region        = "eu-central-1"
env           = "dev"

# VPC
main_vpc_cidr = "10.0.0.0/16"
public_subnet_cidrs = {
  a = "10.0.0.0/24",
  b = "10.0.1.0/24",
  # c = "10.0.2.0/24"
}
private_subnet_cidrs = {
  a = "10.0.16.0/20",
  b = "10.0.32.0/20",
  # c = "10.0.48.0/20"
}
