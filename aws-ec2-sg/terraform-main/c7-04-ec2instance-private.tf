module "ec2_private" {
  depends_on = [module.vpc]
  source     = "terraform-aws-modules/ec2-instance/aws"
  version    = "5.5.0"

  # required variables
  name = "${var.environment}-bastion-host"

  key_name = aws_key_pair.generated_key.key_name
  ami      = data.aws_ami.amzlinux2.id
  # monitoring             = true
  # subnet_id              = module.vpc.public_subnets[0]
  # vpc_security_group_ids = [module.public_bastion_sg.this_security_group_id]
  vpc_security_group_ids = [module.private_sg.security_group_id]
  for_each               = local.multiple_instances
  instance_type          = each.value.instance_type
  subnet_id              = each.value.subnet_id
  availability_zone      = each.value.availability_zone


  user_data = file("${path.module}/app1-install.sh")

  tags = local.common_tags
}
