provider "aws" {
  region = var.aws_region
}

resource "aws_default_vpc" "default" {
}

# Availability Zones Datasource
data "aws_availability_zones" "my_azones" {
  filter {
    name   = "opt-in-status"
    values = ["opt-in-not-required"]
  }
}

# EC2 Instance
resource "aws_instance" "myec2" {
  ami = data.aws_ami.amzlinux2.id
  instance_type = var.instance_type
  user_data = file("${path.module}/app1-install.sh")
  key_name = var.instance_keypair
  security_groups = [aws_security_group.allow_http.name, aws_security_group.allow_ssh.name]
  # Create EC2 Instance in all Availabilty Zones of a VPC  
  for_each = toset(data.aws_availability_zones.my_azones.names)
  availability_zone = each.key
  tags = {
    Name = "For-Each-Demo-${each.key}"
  }
}