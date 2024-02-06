
resource "aws_security_group" "allow_http_2" {
  name        = "allow_http_2"
  description = "Allow HTTP inbound traffic and all outbound traffic"
  vpc_id      = aws_default_vpc.default.id

  tags = {
    Name = "terraform_http_sg"
  }
}

resource "aws_security_group" "allow_ssh_2" {
  name        = "allow_ssh_2"
  description = "Allow SSH inbound traffic and all outbound traffic"
  vpc_id      = aws_default_vpc.default.id

  tags = {
    Name = "terraform_ssh_sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh_2_port" {
  security_group_id = aws_security_group.allow_ssh_2.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_vpc_security_group_ingress_rule" "allow_http_2_port" {
  security_group_id = aws_security_group.allow_http_2.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.allow_http_2.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}