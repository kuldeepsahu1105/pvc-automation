# Common: vars
aws_region   = "ap-southeast-1"

# Tags to apply to the key pair (e.g., owner and environment)
pvc_cluster_tags = {
  owner       = "ksahu-ygulati" # Set your owner tag
  environment = "development"   # Set your environment tag
}

# Keypair creation: vars
# Set the flag to decide whether to create a new key pair or use an existing one
create_keypair = true # Set to false if you want to use an existing key pair

# Name of the new key pair to be created (used if create_keypair is true)
keypair_name = "pvc-new-keypair" # Change this to the desired key pair name

# Name of the existing key pair (used if create_keypair is false)
existing_keypair_name = "kuldeep-pvc-session" # Set this to the name of an existing key pair if create_keypair is false

# EIP creation: vars
create_eip    = true
cldr_eip_name = "cldr-mngr-eip"

# Security group creation: vars
allowed_cidrs = ["0.0.0.0/0"]
allowed_ports = [0]
vpc_id        = "vpc-9d9385fa"
sg_name       = "pvc_cluster_sg"
create_new_sg = false
existing_sg   = "sg-237b7452"

# VPC creation: vars
create_vpc         = true
vpc_name           = "cloudera-vpc"
vpc_cidr_block           = "10.0.0.0/16"
azs = ["ap-southeast-1a", "ap-southeast-1b"]
public_subnets_cidr     = ["10.0.1.0/24", "10.0.2.0/24"]
private_subnets_cidr    = []
enable_nat_gateway = false
enable_vpn_gateway = false

# EC2 Groups Definition: vars
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
