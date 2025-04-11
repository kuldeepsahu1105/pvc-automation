module "key-pair" {
  source                = "./modules/key-pair"
  create_keypair        = var.create_keypair
  keypair_name          = var.keypair_name
  existing_keypair_name = var.existing_keypair_name
  keypair_tags          = var.pvc_cluster_tags
}

module "elastic-ip" {
  source     = "./modules/elastic-ip"
  create_eip = var.create_eip
  eip_name   = var.cldr_eip_name
  eip_tags   = var.pvc_cluster_tags
}

module "vpc" {
  source               = "./modules/vpc"
  create_vpc           = var.create_vpc
  vpc_cidr_block       = var.vpc_cidr_block
  azs                  = var.azs
  private_subnets_cidr = var.private_subnets_cidr
  public_subnets_cidr  = var.public_subnets_cidr
  enable_nat_gateway   = var.enable_nat_gateway
  enable_vpn_gateway   = var.enable_vpn_gateway
  vpc_name             = var.vpc_name
  vpc_tags             = var.pvc_cluster_tags
}

module "security_group" {
  source         = "./modules/security-group"
  sg_name        = var.sg_name
  sg_description = "Allow traffic for the VPC"
  vpc_id         = module.vpc.vpc_id
  allowed_ports  = var.allowed_ports
  allowed_cidrs  = var.allowed_cidrs
  sg_tags        = var.pvc_cluster_tags
  create_new_sg  = var.create_new_sg
  existing_sg    = var.existing_sg
}

module "ec2_instances" {
  source = "./modules/ec2-instance"

  vpc_id            = module.vpc.vpc_id
  subnet_id         = module.vpc.subnet_ids[0] # or loop if needed
  security_group_id = module.security_group.security_group_id
  key_name          = module.key-pair.keypair_name
  pvc_cluster_tags  = var.pvc_cluster_tags
  instance_groups   = var.instance_groups
}
