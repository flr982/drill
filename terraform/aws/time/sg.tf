resource "aws_security_group" "time_asg" {
  name = "${var.project}-sg-asg-${var.env}"
  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.time_lb.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  vpc_id = data.terraform_remote_state.vpc.outputs.vpc_id
  tags = merge(
    local.common_tags,
    {
      Name = "${var.project}-asg-${var.env}"
    }
  )

  lifecycle {
    ignore_changes = [ingress]
  }
}

resource "aws_security_group" "time_lb" {
  name = "${var.project}-sg-lb-${var.env}"
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [var.allow_ip]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  vpc_id = data.terraform_remote_state.vpc.outputs.vpc_id
  tags = merge(
    local.common_tags,
    {
      Name = "${var.project}-lb-${var.env}"
    }
  )
}
