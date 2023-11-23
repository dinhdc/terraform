
module "public_bastion_sg" {
  source = "terraform-aws-modules/security-group/aws"
  version = "5.1.0"

  name = "public-bastion-sg"
  description = "Security Group with SSH port open for everyone"

  vpc_id = module.vpc.vpc_id

  # ingress rule and cidr block
  ingress_rules = ["ssh-tcp"]
  ingress_cidr_blocks = ["0.0.0.0/0"]

  # egress rule and all open
  egress_rules = ["all-all"]
  tags = local.common_tags
}