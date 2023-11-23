# Create Elastic IP for Bastion Host
# Resource depends_on Meta-Argument
resource "aws_eip" "lb" {

  depends_on = [
    module.ec2_public,
    module.vpc
  ]

  instance = module.ec2_public.id[0]

  tags = local.common_tags
}
