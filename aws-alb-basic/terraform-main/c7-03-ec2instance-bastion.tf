module "ec2_public" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "5.5.0"

  # required variables
  name = "${var.environment}-bastion-host"

  instance_type = var.instance_type
  key_name      = aws_key_pair.generated_key.key_name

  ami = data.aws_ami.amzlinux2.id
  # monitoring             = true
  # vpc_security_group_ids = ["sg-12345678"]
  subnet_id              = module.vpc.public_subnets[0]
  vpc_security_group_ids = [module.public_bastion_sg.security_group_id]

  tags = local.common_tags
}
