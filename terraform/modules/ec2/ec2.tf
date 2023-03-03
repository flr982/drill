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
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = var.type
  key_name                    = var.key_name
  vpc_security_group_ids      = [aws_security_group.instance.id]
  subnet_id                   = var.subnet_id
  associate_public_ip_address = true

  user_data = <<-EOF
              #!/bin/bash
              echo "Hello, World from $(hostname -f)">index.html
              EC2_AVAIL_ZONE=`curl -s http://169.254.169.254/latest/meta-data/placement/availability-zone`
              EC2_REGION="`echo \"$EC2_AVAIL_ZONE\" | sed 's/[a-z]$//'`"
              echo "$EC2_AVAIL_ZONE" >> index.html
              echo "$EC2_REGION" >> index.html
              nohup busybox httpd -f -p ${var.server_port} &
              EOF

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

  lifecycle {
    create_before_destroy = true
  }
}
