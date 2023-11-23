module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  version = "5.2.0"

  # VPC Basic Details
  name = "vpc-dev"
  cidr = "10.0.0.0/16"
  azs             = ["ap-southeast-1a", "ap-southeast-1b"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24"]

  # Database subnets
  create_database_subnet_group = true
  create_database_subnet_route_table = true

  database_subnets = ["10.0.151.0/24", "10.0.152.0/24"]

  # NAT Gateway
  enable_nat_gateway = true
  single_nat_gateway = true

  # VPC DNS
  enable_dns_hostnames = true
  enable_dns_support = true

  public_subnet_tags = {
    Type = "public-subnets"
  }

  private_subnet_tags = {
    Type = "private-subnets"
  }

  database_subnet_tags = {
    Type = "database-subnets"
  }

  tags = {
    Owner = "dinh"
    Environment = "dev"
  }

  vpc_tags = {
    Name = "vpc-dev"
  }
}