project       = "drill"
region        = "eu-central-1"
env           = "dev"
main_vpc_cidr = "10.0.0.0/16"
public_subnet_cidrs = {
  a = "10.0.1.0/24",
  b = "10.0.2.0/24",
  c = "10.0.3.0/24"
}
private_subnet_cidrs = {
  a = "10.0.4.0/24",
  b = "10.0.5.0/24",
  c = "10.0.6.0/24"
}
