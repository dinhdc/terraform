# Define Local Values in Terraform
locals {
  owners      = var.business_divsion
  environment = var.environment
  name        = "${var.business_divsion}-${var.environment}"
  #name = "${local.owners}-${local.environment}"
  common_tags = {
    owners      = local.owners
    environment = local.environment
  }

  multiple_instances = {
    0 = {
      num_suffix        = 1
      instance_type     = var.instance_type
      subnet_id         = element(module.vpc.private_subnets, 0)
      # availability_zone = "ap-southeast-1a"
      # availability_zone = var.vpc_availability_zones[0]
    }
    1 = {
      num_suffix        = 2
      instance_type     = var.instance_type
      subnet_id         = element(module.vpc.private_subnets, 1)
      # availability_zone = "ap-southeast-1b"
      # availability_zone = var.vpc_availability_zones[1]
    }
  }
}
