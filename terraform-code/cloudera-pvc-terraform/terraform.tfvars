# region   = "us-east-1"
# env_name = "pvc"
# owner    = "team"

# create_key_pair = true
# key_pair_name   = "cloudera-auto-key"
# pem_file_path   = ""

# create_vpc         = true
# vpc_name           = "cloudera-vpc"
# vpc_cidr           = "10.0.0.0/16"
# availability_zones = ["us-east-1a", "us-east-1b"]
# public_subnets     = ["10.0.1.0/24", "10.0.2.0/24"]
# private_subnets    = ["10.0.3.0/24", "10.0.4.0/24"]
# enable_nat_gateway = false

# allowed_ports = [22, 443, 9870, 9864]
# allowed_cidr  = "0.0.0.0/0"

# enable_elastic_ip = true

# ec2_groups = {
#   "freeipa" = {
#     instance_count = 1
#     instance_type  = "t3.medium"
#     volume_size    = 50
#     ami_id         = "ami-0abcdef1234567890"
#     os_user        = "ec2-user"
#   },
#   "cldr-mngr" = {
#     instance_count = 1
#     instance_type  = "t3.large"
#     volume_size    = 100
#     ami_id         = "ami-0abcdef1234567890"
#     os_user        = "ec2-user"
#   }
#   # Add base-master, base-worker, ecs-master, ecs-worker...
#   "base-master" = {
#     instance_count = 1
#     instance_type  = "t3.large"
#     volume_size    = 100
#     ami_id         = "ami-0abcdef1234567890"
#     os_user        = "ec2-user"
#   },
#   "base-worker" = {
#     instance_count = 1
#     instance_type  = "t3.large"
#     volume_size    = 100
#     ami_id         = "ami-0abcdef1234567890"
#     os_user        = "ec2-user"
#   },
#   "ecs-master" = {
#     instance_count = 1
#     instance_type  = "t3.large"
#     volume_size    = 100
#     ami_id         = "ami-0abcdef1234567890"
#     os_user        = "ec2-user"
#   },
#   "ecs-worker" = {
#     instance_count = 1
#     instance_type  = "t3.large"
#     volume_size    = 100
#     ami_id         = "ami-0abcdef1234567890"
#     os_user        = "ec2-user"
#   }
# }


# env_name              = "dev"
# owner                 = "your-name"
# pvcbase_master_count  = 2
# pvcbase_worker_count  = 6
# pvcecs_master_count   = 1
# pvcecs_worker_count   = 10
# create_elastic_ip     = true
# create_custom_vpc     = false
# custom_vpc_subnets    = 2
# allowed_cidr          = "0.0.0.0/0"



# Set the flag to decide whether to create a new key pair or use an existing one
create_keypair = true # Set to false if you want to use an existing key pair

create_eip = true

cldr_eip_name = "cldr-mngr-eip"
# Name of the new key pair to be created (used if create_keypair is true)
keypair_name = "pvc-new-keypair" # Change this to the desired key pair name

# Name of the existing key pair (used if create_keypair is false)
existing_keypair_name = "kuldeep-pvc-session" # Set this to the name of an existing key pair if create_keypair is false

# Tags to apply to the key pair (e.g., owner and environment)
pvc_cluster_tags = {
  owner       = "ksahu-ygulati" # Set your owner tag
  environment = "development"   # Set your environment tag
}

allowed_cidrs = ["0.0.0.0/0"]
allowed_ports = [0]
vpc_id        = "vpc-9d9385fa"
sg_name       = "pvc_cluster_sg"
create_new_sg = false
existing_sg   = "sg-237b7452"


