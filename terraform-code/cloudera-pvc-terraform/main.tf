module "key_pair" {
  source              = "./modules/key-pair"
  create_key_pair     = var.create_key_pair
  key_pair_name       = var.key_pair_name
  pem_file_path       = var.pem_file_path
}

module "vpc" {
  source              = "./modules/vpc"
  create_vpc          = var.create_vpc
  vpc_name            = var.vpc_name
  vpc_cidr            = var.vpc_cidr
  availability_zones  = var.availability_zones
  public_subnets      = var.public_subnets
  private_subnets     = var.private_subnets
  enable_nat_gateway  = var.enable_nat_gateway
  env_name            = var.env_name
  owner               = var.owner
}

module "security_group" {
  source        = "./modules/security-group"
  vpc_id        = module.vpc.vpc_id
  allowed_ports = var.allowed_ports
  allowed_cidr  = var.allowed_cidr
  env_name      = var.env_name
  owner         = var.owner
}

module "elastic_ip" {
  source            = "./modules/elastic-ip"
  enable_elastic_ip = var.enable_elastic_ip
}

module "ec2_instance" {
  source               = "./modules/ec2-instance"
  region               = var.region
  subnet_ids           = module.vpc.subnet_ids
  sg_id                = module.security_group.sg_id
  key_name             = module.key_pair.key_name
  ec2_groups           = var.ec2_groups
  env_name             = var.env_name
  owner                = var.owner
  elastic_ip           = module.elastic_ip.eip
}