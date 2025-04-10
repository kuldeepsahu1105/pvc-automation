# Common: vars
# region   = "us-east-1"

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
# create_vpc         = true
vpc_name = "cloudera-vpc"
# vpc_cidr           = "10.0.0.0/16"
# availability_zones = ["us-east-1a", "us-east-1b"]
# public_subnets     = ["10.0.1.0/24", "10.0.2.0/24"]
# private_subnets    = ["10.0.3.0/24", "10.0.4.0/24"]
# enable_nat_gateway = false

# EC2 Groups Definition: vars
subnet_id         = "subnet-0123456789abcdef0"
security_group_id = "sg-0123456789abcdef0"
key_name          = "my-key-pair"

instance_groups = {
  cldr_mngr = {
    count         = 1
    ami           = "ami-0abcdef1234567890"
    instance_type = "t3.medium"
    volume_size   = 30
    tags = {
      Name        = "cldr-mngr"
      owner       = "ksahu-ygulati"
      environment = "development"
    }
  },
  ipa_server = {
    count         = 1
    ami           = "ami-0abcdef1234567890"
    instance_type = "t3.medium"
    volume_size   = 30
    tags = {
      Name        = "ipa-server"
      owner       = "ksahu-ygulati"
      environment = "development"
    }
  },
  pvcbase_master = {
    count         = 2
    ami           = "ami-0abcdef1234567890"
    instance_type = "t3.large"
    volume_size   = 50
    tags = {
      Name        = "pvcbase-master"
      owner       = "ksahu-ygulati"
      environment = "development"
    }
  },
  pvcbase_worker = {
    count         = 6
    ami           = "ami-0abcdef1234567890"
    instance_type = "t3.large"
    volume_size   = 50
    tags = {
      Name        = "pvcbase-worker"
      owner       = "ksahu-ygulati"
      environment = "development"
    }
  },
  pvcecs_master = {
    count         = 1
    ami           = "ami-0abcdef1234567890"
    instance_type = "t3.xlarge"
    volume_size   = 100
    tags = {
      Name        = "pvcecs-master"
      owner       = "ksahu-ygulati"
      environment = "development"
    }
  },
  pvcecs_worker = {
    count         = 10
    ami           = "ami-0abcdef1234567890"
    instance_type = "t3.xlarge"
    volume_size   = 100
    tags = {
      Name        = "pvcecs-worker"
      owner       = "ksahu-ygulati"
      environment = "development"
    }
  }
}
