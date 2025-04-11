aws_region = "ap-southeast-1"

pvc_cluster_tags = {
  owner       = "ksahu-ygulati"
  environment = "development"
}

# Keypair
create_keypair        = true
keypair_name          = "pvc-new-keypair"
existing_keypair_name = "kuldeep-pvc-session"

# Elastic IP
create_eip    = true
cldr_eip_name = "cldr-mngr-eip"

# Security Group
allowed_cidrs = ["0.0.0.0/0"]
allowed_ports = [0]
sg_name       = "pvc_cluster_sg"
create_new_sg = false
existing_sg   = "sg-237b7452"

# VPC
create_vpc           = true
vpc_name             = "cloudera-vpc"
vpc_cidr_block       = "10.0.0.0/16"
azs                  = ["ap-southeast-1a", "ap-southeast-1b"]
public_subnets_cidr  = ["10.0.1.0/24", "10.0.2.0/24"]
private_subnets_cidr = []
enable_nat_gateway   = false
enable_vpn_gateway   = false

# EC2 vars

# EC2 Groups Definition: vars
vpc_id            = "vpc-9d9385fa"
subnet_id         = "subnet-6346ad2b"
security_group_id = "sg-0dbb6f79cba5ef701"
key_name          = "kuldeep-pvc-session"

instance_groups = {
  cldr_mngr = {
    count         = 1
    ami           = "ami-06dc977f58c8d7857"
    instance_type = "t3.medium"
    volume_size   = 30
    tags          = { Name = "cldr-mngr" }
  },
  ipa_server = {
    count         = 1
    ami           = "ami-06dc977f58c8d7857"
    instance_type = "t3.medium"
    volume_size   = 30
    tags          = { Name = "ipa-server" }
  },
  pvcbase_master = {
    count         = 1
    ami           = "ami-06dc977f58c8d7857"
    instance_type = "t3.large"
    volume_size   = 50
    tags          = { Name = "pvcbase-master" }
  },
  pvcbase_worker = {
    count         = 1
    ami           = "ami-06dc977f58c8d7857"
    instance_type = "t3.large"
    volume_size   = 50
    tags          = { Name = "pvcbase-worker" }
  },
  pvcecs_master = {
    count         = 1
    ami           = "ami-06dc977f58c8d7857"
    instance_type = "t3.xlarge"
    volume_size   = 100
    tags          = { Name = "pvcecs-master" }
  },
  pvcecs_worker = {
    count         = 1
    ami           = "ami-06dc977f58c8d7857"
    instance_type = "t3.xlarge"
    volume_size   = 100
    tags          = { Name = "pvcecs-worker" }
  }
}
