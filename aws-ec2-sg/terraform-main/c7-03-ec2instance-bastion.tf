module "ec2_public" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "5.5.0"

  # required variables
  name = "${var.environment}-bastion-host"

  instance_type = var.instance_type
  key_name      = var.instance_keypair
  ami           = data.aws_ami.amzlinux2
  # monitoring             = true
  # vpc_security_group_ids = ["sg-12345678"]
  subnet_id              = module.vpc.public_subnets[0]
  vpc_security_group_ids = [module.public_bastion_sg.this_security_group_id]

  tags = local.common_tags
}
