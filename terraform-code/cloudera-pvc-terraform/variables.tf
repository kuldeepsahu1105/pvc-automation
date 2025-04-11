# variable "region" {}
# variable "env_name" {}
# variable "owner" {}

# # Key Pair
# variable "create_key_pair" { default = true }
# variable "key_pair_name" { default = "cloudera-key" }
# variable "pem_file_path" { default = "" }

# # VPC
# variable "create_vpc" { default = false }
# variable "vpc_name" { default = "cloudera-vpc" }
# variable "vpc_cidr" { default = "10.0.0.0/16" }
# variable "availability_zones" {
#   type        = list(string)
#   default     = ["us-east-1a", "us-east-1b"]
#   description = "List of availability zones to use for the VPC"
# }
# variable "public_subnets_cidr" { type = list(string) }
# variable "private_subnets_cidr" { type = list(string) }
# variable "enable_nat_gateway" { default = false }

# # SG
# variable "allowed_ports" {
#   type        = list(number)
#   default     = [22, 80, 443, 8080]
#   description = "List of allowed ports for the security group"
# }
# variable "allowed_cidr" { default = "0.0.0.0/0" }

# # EIP
# variable "enable_elastic_ip" { default = false }

# # EC2 Groups Definition
# variable "ec2_groups" {
#   type = map(object({
#     instance_count = number
#     instance_type  = string
#     volume_size    = number
#     ami_id         = string
#     os_user        = string
#   }))
# }


variable "aws_region" {
  description = "AWS region to deploy pvc cluster infra"
  type        = string
  default     = "ap-southeast-1"
}

variable "create_keypair" {
  description = "Flag to decide whether to create a new key pair or use an existing one"
  type        = bool
  default     = true
}

variable "keypair_name" {
  description = "Name of the key pair"
  type        = string
}

variable "existing_keypair_name" {
  description = "The name of the existing key pair (if using an existing one)"
  type        = string
  default     = ""
}

variable "cldr_eip_name" {
  description = "Name of the elastic ip"
  type        = string
}

variable "create_eip" {
  description = "Flag to decide whether to create an eip for cloudera manager"
  type        = bool
  default     = true
}

variable "sg_name" {
  description = "Name of the security group"
  type        = string
  default     = "pvc_cluster_sg"
}

variable "vpc_id" {
  description = "The VPC ID where the security group will be created"
  type        = string
  default     = "vpc-9d9385fa"
}

variable "allowed_ports" {
  description = "List of allowed ports"
  type        = list(number)
  default     = [0]
}

variable "allowed_cidrs" {
  description = "List of CIDR blocks allowed to access the ports"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "create_new_sg" {
  description = "Flag to decide whether to create a new security group or use an existing one"
  type        = bool
  default     = true
}

variable "existing_sg" {
  description = "The name of the existing security group (if using an existing one)"
  type        = string
  default     = ""
}

variable "subnet_id" {
    description = "Subnet ID where the instances will be deployed"
    type        = string
    default     = "subnet-6346ad2b"
}

variable "security_group_id" {
    description = "Security Group ID to associate with the instances"
    type        = string
    default     = "sg-0dbb6f79cba5ef701"
}

variable "key_name" {
    description = "Key pair name to use for the instances"
    type        = string
    default     = "kuldeep-pvc-session"
}

variable "pvc_cluster_tags" {
  description = "Tags to apply to all EC2 instances"
  type = map(string)
  default = {
    owner       = "ksahu-ygulati"
    environment = "development"
  }
}

# EC2
variable "instance_groups" {
  description = "EC2 instance groups with individual configurations"
  type = map(object({
    count         = number
    ami           = string
    instance_type = string
    volume_size   = number
    tags          = map(string)
    user_data     = optional(string)
  }))
  default = {
    cldr_mngr = {
      count         = 1
      ami           = "ami-12345678"
      instance_type = "t3.medium"
      volume_size   = 30
      tags          = { Name = "cldr-mngr" }
    },
    ipa_server = {
      count         = 1
      ami           = "ami-12345678"
      instance_type = "t3.medium"
      volume_size   = 30
      tags          = { Name = "ipa-server" }
    },
    pvcbase_master = {
      count         = 2
      ami           = "ami-12345678"
      instance_type = "t3.large"
      volume_size   = 50
      tags          = { Name = "pvcbase-master" }
    },
    pvcbase_worker = {
      count         = 6
      ami           = "ami-12345678"
      instance_type = "t3.large"
      volume_size   = 50
      tags          = { Name = "pvcbase-worker" }
    },
    pvcecs_master = {
      count         = 1
      ami           = "ami-12345678"
      instance_type = "t3.xlarge"
      volume_size   = 100
      tags          = { Name = "pvcecs-master" }
    },
    pvcecs_worker = {
      count         = 10
      ami           = "ami-12345678"
      instance_type = "t3.xlarge"
      volume_size   = 100
      tags          = { Name = "pvcecs-worker" }
    }
  }
}

# VPC
variable "create_vpc" {
  description = "Whether to create a new VPC or use the default one"
  type        = bool
  default     = false
}

variable "vpc_name" {
  description = "Name of new VPC or use the default one"
  type        = string
  default     = "cloudera-vpc"
}

variable "vpc_tags" {
  description = "Map of tags to apply to the key pair (owner and environment)"
  type        = map(string)
  default = {
    owner       = "ksahu-ygulati" 
    environment = "development"   
  }
}

variable "vpc_cidr_block" {
  type        = string
  default     = "10.0.0.0/16"
}

variable "azs" {
  type = list(string)
  default = []
}

variable "private_subnets_cidr" {
  type = list(string)
  default = []
}

variable "public_subnets_cidr" {
  type = list(string)
  default = []
}

variable "enable_nat_gateway" {
  type    = bool
  default = false
}

variable "enable_vpn_gateway" {
  type    = bool
  default = false
}
