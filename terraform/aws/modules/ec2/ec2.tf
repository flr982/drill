data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "server" {
  # ami                    = lookup(var.ami, var.region)
  count                       = var.server_count
  # ami                         = data.aws_ami.ubuntu.id
  ami                         = var.ami
  instance_type               = var.type
  key_name                    = var.key_name
  vpc_security_group_ids      = [aws_security_group.instance.id]
  subnet_id                   = var.subnet_id
  associate_public_ip_address = true


  tags = merge(
    var.common_tags,
    {
      Name = "${var.server_name_prefix}-${count.index}"
    }
  )
}


resource "aws_security_group" "instance" {
  name   = "${var.project}-ec2-sg-${var.env}"
  vpc_id = var.vpc_id

  tags = var.common_tags

  ingress {
    from_port   = var.server_port
    to_port     = var.server_port
    protocol    = "tcp"
    cidr_blocks = [var.allow_ip]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.allow_ip]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  lifecycle {
    create_before_destroy = true
  }
}
