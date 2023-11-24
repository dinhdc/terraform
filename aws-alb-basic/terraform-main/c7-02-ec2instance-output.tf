# AWS EC2 Instance Terraform Outputs
# Public EC2 Instances - Bastion Host

## ec2_bastion_public_instance_ids
output "ec2_bastion_public_instance_ids" {
  description = "List of IDs of instances"
  value       = module.ec2_public.id
}

## ec2_bastion_public_ip
output "ec2_bastion_public_ip" {
  description = "List of public IP addresses assigned to the instances"
  value       = module.ec2_public.public_ip
}

# Private EC2 Instances
output "ec2_private_instance_ids" {
  description = "Map of instance IDs for private EC2 instances"
  value       = { for key, instance in module.ec2_private : key => instance.id }
}

output "ec2_private_instance_azs" {
  description = "Map of instance IDs for private EC2 instances"
  value       = { for key, instance in module.ec2_private : key => instance.availability_zone }
}

output "ec2_private_ip" {
  description = "Map of private IP addresses for private EC2 instances"
  value       = { for key, instance in module.ec2_private : key => instance.private_ip }
}
