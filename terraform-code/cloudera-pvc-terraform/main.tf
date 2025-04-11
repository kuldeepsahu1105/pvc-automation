# This is the main Terraform configuration file for deploying a Cloudera PVC cluster on AWS.

module "key-pair" {
  source                = "./modules/key-pair"
  create_keypair        = var.create_keypair
  keypair_name          = var.keypair_name
  existing_keypair_name = var.existing_keypair_name # The name of the existing key pair
  keypair_tags          = var.pvc_cluster_tags
}

module "elastic-ip" {
  source     = "./modules/elastic-ip" # path to your module folder
  create_eip = var.create_eip
  eip_name   = var.cldr_eip_name
  eip_tags   = var.pvc_cluster_tags
}

module "security_group" {
  source         = "./modules/security-group"  # Adjust the path based on where your module is located
  sg_name        = "pvc_cluster_sg"            # Security group name
  sg_description = "Allow traffic for the VPC" # Security group description
  vpc_id         = var.vpc_id                  # VPC ID to attach the security group to
  allowed_ports  = var.allowed_ports           # List of allowed ports (change based on your use case)
  allowed_cidrs  = var.allowed_cidrs           # List of allowed CIDR blocks for ingress
  sg_tags        = var.pvc_cluster_tags
  create_new_sg  = var.create_new_sg
  existing_sg    = var.existing_sg
}

module "vpc" {
  source = "./modules/vpc"

  create_vpc         = true
  vpc_cidr_block     = "10.0.0.0/16"
  azs                = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]
  private_subnets    = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets     = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
  enable_nat_gateway = true
  enable_vpn_gateway = false
  vpc_name           = "pvc-vpc"
  vpc_tags           = var.pvc_cluster_tags
  # tags = {  
  #   Terraform   = "true"
  #   Environment = "dev"
  # }
}

module "ec2_instances" {
  source = "./modules/ec2-instance"

  vpc_id            = var.vpc_id
  subnet_id         = var.subnet_id
  security_group_id = var.security_group_id
  key_name          = var.key_name
  pvc_cluster_tags  = var.pvc_cluster_tags
  instance_groups   = var.instance_groups
}
