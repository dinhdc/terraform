provider "aws" {
  region = var.aws_region
}

resource "aws_default_vpc" "default" {
}

# EC2 Instance
resource "aws_instance" "myec2" {
  ami = data.aws_ami.amzlinux2.id
  instance_type = var.instance_type
  user_data = file("${path.module}/app1-install.sh")
  key_name = var.instance_keypair
  security_groups = [aws_security_group.allow_http.name, aws_security_group.allow_ssh.name]
  count = 2
  tags = {
    "Name" = "Count-Demo-${count.index}"
  }
}