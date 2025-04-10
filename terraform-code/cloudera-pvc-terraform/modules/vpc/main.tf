module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  version = "4.0.2"

  create_vpc           = var.create_vpc
  name                 = var.vpc_name
  cidr                 = var.vpc_cidr
  azs                  = var.availability_zones
  public_subnets       = var.public_subnets
  private_subnets      = var.private_subnets
  enable_nat_gateway   = var.enable_nat_gateway
  single_nat_gateway   = true
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Environment = var.env_name
    Owner       = var.owner
  }
}
