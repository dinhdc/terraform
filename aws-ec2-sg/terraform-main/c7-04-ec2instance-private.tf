module "ec2_private" {
  depends_on = [ module.vpc ]
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "5.5.0"

  # required variables
  name = "${var.environment}-bastion-host"

  instance_type = var.instance_type
  key_name      = var.instance_keypair
  ami           = data.aws_ami.amzlinux2
  # monitoring             = true
  # subnet_id              = module.vpc.public_subnets[0]
  vpc_security_group_ids = [module.public_bastion_sg.this_security_group_id]
  subnet_id = [
    module.vpc.private_subnets[0],
    module.vpc.private_subnets[1]
  ]

  user_data = file("${path.module}/app1-install.sh")

  tags = local.common_tags
}
