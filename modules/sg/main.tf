# create a security for the public instances

resource "aws_security_group" "public-sg" {
  name = "${var.project-name}-public-sg"
  description = "allow ssh http and https inbound traffic and all outbound traffic"
  vpc_id = var.vpc_id

  ingress {
    from_port = "22"
    to_port = "22"
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = "80"
    to_port = "80"
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = "443"
    to_port = "443"
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = "-1"
    to_port = "-1"
    protocol = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = "0"
    to_port = "0"
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

############################################################################



resource "aws_security_group" "load_balancer_sg" {
  name = "var.load_balancer_sg_name"
  description = "Allows SSH, HTTP and HTTPS traffic"
  vpc_id = var.vpc_id

  ingress {
    description = "HTTP"
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

ingress {
  description = "HTTPS"
  from_port = 443
  to_port = 443
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}


egress {
  from_port = 0
  to_port = 0
  protocol = "-1"
  cidr_blocks = ["0.0.0.0/0"]
}

tags = {
  Name = "var.load_balancer_sg_name"
}
}