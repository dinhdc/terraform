locals {
  multiple_instances = {
    0 = {
      num_suffix    = 1
      instance_type = var.instance_type
      subnet_id     = element(module.vpc.private_subnets, 0)
      availability_zone = element(var.vpc_availability_zones, 0)
    }
    1 = {
      num_suffix    = 2
      instance_type = var.instance_type
      subnet_id     = element(module.vpc.private_subnets, 1)
      availability_zone = element(var.vpc_availability_zones, 1)
    }
  }

}
