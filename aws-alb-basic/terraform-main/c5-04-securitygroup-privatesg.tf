
module "private_sg" {
  source = "terraform-aws-modules/security-group/aws"
  version = "5.1.0"

  name = "private-sg"
  description = "Security Group with HTTP & SSH port open for entire VPC Blocks"

  vpc_id = module.vpc.vpc_id

  # ingress rule and cidr block
  ingress_rules = ["ssh-tcp", "http-80-tcp"]
  ingress_cidr_blocks = [module.vpc.vpc_cidr_block]

  # egress rule and all open
  egress_rules = ["all-all"]
  tags = local.common_tags
}