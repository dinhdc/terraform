provider "aws" {
  region = "us-east-1"
}

resource "aws_default_vpc" "default" {
}

resource "aws_security_group" "allow_http" {
  name        = "allow_http"
  description = "Allow HTTP inbound traffic and all outbound traffic"
  vpc_id      = aws_default_vpc.default.id

  tags = {
    Name = "terraform_sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_http_port" {
  security_group_id = aws_security_group.allow_http.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.allow_http.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

resource "aws_instance" "myec2" {
  ami             = "ami-0277155c3f0ab2930"
  instance_type   = "t2.micro"
  user_data       = file("${path.module}/app1-install.sh")
  security_groups = [aws_security_group.allow_http.name]
  tags = {
    Name      = "EC2 Demo"
    Terraform = "true"
  }
}


output "ec2_public_ip" {
  value = aws_instance.myec2.public_ip
}

output "ec2_userdata" {
  value = aws_instance.myec2.user_data
}
