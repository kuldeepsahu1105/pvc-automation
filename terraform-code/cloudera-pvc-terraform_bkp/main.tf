module "vpc" {
  source            = "./modules/vpc"
  create_custom_vpc = var.create_custom_vpc
  subnet_count      = var.custom_vpc_subnets
}

module "security_group" {
  source       = "./modules/security-group"
  vpc_id       = module.vpc.vpc_id
  allowed_cidr = var.allowed_cidr
  env_name     = var.env_name
  owner        = var.owner
}

module "freeipa" {
  source        = "./modules/ec2-instance"
  instance_name = "freeipa"
  count         = 1
  env_name      = var.env_name
  owner         = var.owner
  sg_id         = module.security_group.sg_id
  subnet_id     = module.vpc.subnet_ids[0]
}

module "cldr-mngr" {
  source        = "./modules/ec2-instance"
  instance_name = "cldr-mngr"
  count         = 1
  env_name      = var.env_name
  owner         = var.owner
  sg_id         = module.security_group.sg_id
  subnet_id     = module.vpc.subnet_ids[0]
  associate_eip = var.create_elastic_ip
}

# Repeat for pvcbase-master, pvcbase-worker, etc.
module "pvcbase-master" {
  source        = "./modules/ec2-instance"
  instance_name = "pvcbase-master"
  count         = var.pvcbase_master_count
  env_name      = var.env_name
  owner         = var.owner
  sg_id         = module.security_group.sg_id
  subnet_id     = module.vpc.subnet_ids[0]
}

module "pvcbase-worker" {
  source        = "./modules/ec2-instance"
  instance_name = "pvcbase-worker"
  count         = var.pvcbase_worker_count
  env_name      = var.env_name
  owner         = var.owner
  sg_id         = module.security_group.sg_id
  subnet_id     = module.vpc.subnet_ids[0]
}
module "pvcecs-master" {
  source        = "./modules/ec2-instance"
  instance_name = "pvcecs-master"
  count         = var.pvcecs_master_count
  env_name      = var.env_name
  owner         = var.owner
  sg_id         = module.security_group.sg_id
  subnet_id     = module.vpc.subnet_ids[0]
}
module "pvcecs-worker" {
  source        = "./modules/ec2-instance"
  instance_name = "pvcecs-worker"
  count         = var.pvcecs_worker_count
  env_name      = var.env_name
  owner         = var.owner
  sg_id         = module.security_group.sg_id
  subnet_id     = module.vpc.subnet_ids[0]
}
