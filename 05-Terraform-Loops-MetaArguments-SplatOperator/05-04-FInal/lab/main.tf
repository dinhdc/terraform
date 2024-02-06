provider "aws" {
  region = var.aws_region
}

resource "aws_default_vpc" "default" {
}


# EC2 Instance
resource "aws_instance" "myec2" {
  ami             = data.aws_ami.amzlinux2.id
  instance_type   = var.instance_type
  user_data       = file("${path.module}/app1-install.sh")
  key_name        = var.instance_keypair
  security_groups = [aws_security_group.allow_http_2.name, aws_security_group.allow_ssh_2.name]
  # Create EC2 Instance in all Availabilty Zones of a VPC  
  for_each = toset(keys({ for az, details in data.aws_ec2_instance_type_offerings.my_ins_type :
  az => details.instance_types if length(details.instance_types) != 0 }))
  availability_zone = each.key # You can also use each.value because for list items each.key == each.value
  tags = {
    "Name" = "For-Each-Demo-${each.key}"
  }
}
