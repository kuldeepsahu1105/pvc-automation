# module "key_pair" {
#   source              = "./modules/key-pair"
#   create_key_pair     = var.create_key_pair
#   key_pair_name       = var.key_pair_name
#   pem_file_path       = var.pem_file_path
# }

# module "vpc" {
#   source              = "./modules/vpc"
#   create_vpc          = var.create_vpc
#   vpc_name            = var.vpc_name
#   vpc_cidr            = var.vpc_cidr
#   availability_zones  = var.availability_zones
#   public_subnets      = var.public_subnets
#   private_subnets     = var.private_subnets
#   enable_nat_gateway  = var.enable_nat_gateway
#   env_name            = var.env_name
#   owner               = var.owner
# }

# module "security_group" {
#   source        = "./modules/security-group"
#   vpc_id        = module.vpc.vpc_id
#   allowed_ports = var.allowed_ports
#   allowed_cidr  = var.allowed_cidr
#   env_name      = var.env_name
#   owner         = var.owner
# }

# module "elastic_ip" {
#   source            = "./modules/elastic-ip"
#   enable_elastic_ip = var.enable_elastic_ip
# }

# module "ec2_instance" {
#   source               = "./modules/ec2-instance"
#   region               = var.region
#   subnet_ids           = module.vpc.subnet_ids
#   sg_id                = module.security_group.sg_id
#   key_name             = module.key_pair.key_name
#   ec2_groups           = var.ec2_groups
#   env_name             = var.env_name
#   owner                = var.owner
#   elastic_ip           = module.elastic_ip.eip
# }



module "key-pair" {
  source         = "./modules/key-pair"
  create_keypair = var.create_keypair
  keypair_name   = var.keypair_name
  existing_keypair_name = var.existing_keypair_name # The name of the existing key pair
  keypair_tags          = var.pvc_cluster_tags
}

module "elastic-ip" {
  source = "./modules/elastic-ip"  # path to your module folder
  create_eip = var.create_eip
  eip_name     = var.cldr_eip_name
  eip_tags = var.pvc_cluster_tags
}

module "security_group" {
  source            = "./modules/security-group"  # Adjust the path based on where your module is located
  sg_name           = "pvc_cluster_sg"          # Security group name
  sg_description    = "Allow traffic for the VPC"  # Security group description
  vpc_id            = var.vpc_id                  # VPC ID to attach the security group to
  allowed_ports     = var.allowed_ports        # List of allowed ports (change based on your use case)
  allowed_cidrs     = var.allowed_cidrs               # List of allowed CIDR blocks for ingress
  sg_tags           = var.pvc_cluster_tags
}


