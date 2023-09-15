resource "tls_private_key" "my_key" {
  algorithm = "RSA"
}

# Create an EC2 key pair using the generated private key
resource "aws_key_pair" "my_key_pair" {
  key_name   = "first-ec2"
  public_key = tls_private_key.my_key.public_key_openssh
}

resource "aws_instance" "ec2-terraform" {
  ami           = "ami-0dfb78957e4edea0c"
  instance_type = "t2.micro"
  key_name      = aws_key_pair.my_key_pair.key_name

  tags = {
    Name = "ec2-terraform"
  }

  user_data = <<EOF
    #!bin/bash
    yum update -y
    yum install -y httpd
    systemctl start httpd
    systemctl enable httpd
    echo "<h1>Hello world from \$(hostname -f)</h1>" > /var/www/html/index.html
  EOF

  vpc_security_group_ids = [aws_security_group.allow_http.id]
}

output "instance_ip" {
  value = aws_instance.ec2-terraform.public_ip
}

resource "aws_security_group" "allow_http" {
  name        = "allow_http"
  description = "Allow Http inbound traffic"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Ingress rule 2: Allow SSH traffic (port 22) from a specific IP range
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Replace with your desired IP range
  }

  # Ingress rule 3: Allow HTTPS traffic (port 443) from any source
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Outbound rule for HTTP (port 80)
  egress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Outbound rule for HTTPS (port 443)
  egress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

}
