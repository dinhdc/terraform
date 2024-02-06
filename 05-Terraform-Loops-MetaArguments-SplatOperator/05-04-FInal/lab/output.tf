# Output
output "output_v1_1" {
 value = data.aws_ec2_instance_type_offerings.my_ins_type1.instance_types
}

# EC2 Instance Public IP with TOSET
output "instance_publicip" {
  description = "EC2 Instance Public IP"
  value = toset([
      for myec2vm in aws_instance.myec2 : myec2vm.public_ip
    ])  
}

# EC2 Instance Public DNS with TOSET
output "instance_publicdns" {
  description = "EC2 Instance Public DNS"
  value = toset([
      for myec2vm in aws_instance.myec2 : myec2vm.public_dns
    ])    
}

# EC2 Instance Public DNS with MAPS
output "instance_publicdns2" {
  value = tomap({
    for s, myec2vm in aws_instance.myec2 : s => myec2vm.public_dns
    # S intends to be a subnet ID
  })
}