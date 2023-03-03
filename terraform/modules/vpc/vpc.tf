resource "aws_vpc" "Main" {
  cidr_block           = var.main_vpc_cidr
  instance_tenancy     = "default"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = merge(
    var.common_tags,
    {
      Name = "${var.project}-vpc-${var.env}"
    }
  )
}


resource "aws_subnet" "public_subnet" {
  for_each                = var.public_subnet_cidrs
  vpc_id                  = aws_vpc.Main.id
  cidr_block              = each.value
  map_public_ip_on_launch = true
  availability_zone       = "${var.region}${each.key}"

  tags = merge(
    var.common_tags,
    {
      Name = "${var.project}-pub-${var.env}-${each.key}"
    },
  )
}

resource "aws_subnet" "private_subnet" {
  for_each                = var.private_subnet_cidrs
  vpc_id                  = aws_vpc.Main.id
  cidr_block              = each.value
  map_public_ip_on_launch = false
  availability_zone       = "${var.region}${each.key}"

  tags = merge(
    var.common_tags,
    {
      Name = "${var.project}-prv-${var.env}-${each.key}"
    },
  )
}


resource "aws_internet_gateway" "IGW" {
  vpc_id = aws_vpc.Main.id

  tags = merge(
    var.common_tags,
    {
      Name = "${var.project}-igw-${var.env}"
    },
  )
}



resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.Main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.IGW.id
  }

  tags = merge(
    var.common_tags,
    {
      Name = "${var.project}-pub-${var.env}"
    },
  )
}


# resource "aws_route_table" "private_rt" {
#   vpc_id = aws_vpc.Main.id
#   route {
#     cidr_block     = "0.0.0.0/0"
#     nat_gateway_id = aws_nat_gateway.NATgw.id
#   }

#   tags = merge(
#     var.common_tags,
#     {
#       Name = "${var.project}-prv-${var.env}"
#     },
#   )

# }


resource "aws_route_table_association" "public" {
  for_each       = var.public_subnet_cidrs
  subnet_id      = aws_subnet.public_subnet[each.key].id
  route_table_id = aws_route_table.public_rt.id
}

# resource "aws_route_table_association" "private" {
#   for_each       = var.private_subnet_cidrs
#   subnet_id      = aws_subnet.private_subnet[each.key].id
#   route_table_id = aws_route_table.private_rt.id
# }

# resource "aws_eip" "nateIP" {
#   vpc = true

#   tags = merge(
#     var.common_tags,
#     {
#       Name = "${var.project}-eip-${var.env}"
#     },
#   )
# }

### $0.052 per hour in Frankfurt
# resource "aws_nat_gateway" "NATgw" {
#   allocation_id = aws_eip.nateIP.id
#   subnet_id     = aws_subnet.public_subnet["a"].id

#   tags = merge(
#     var.common_tags,
#     {
#       Name = "${var.project}-natgw-${var.env}"
#     },
#   )
# }
