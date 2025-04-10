variable "region" {}
variable "env_name" {}
variable "owner" {}

# Key Pair
variable "create_key_pair" { default = true }
variable "key_pair_name" { default = "cloudera-key" }
variable "pem_file_path" { default = "" }

# VPC
variable "create_vpc" { default = false }
variable "vpc_name" { default = "cloudera-vpc" }
variable "vpc_cidr" { default = "10.0.0.0/16" }
variable "availability_zones" {
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
  description = "List of availability zones to use for the VPC"
}
variable "public_subnets" { type = list(string) }
variable "private_subnets" { type = list(string) }
variable "enable_nat_gateway" { default = false }

# SG
variable "allowed_ports" {
  type        = list(number)
  default     = [22, 80, 443, 8080]
  description = "List of allowed ports for the security group"
}
variable "allowed_cidr" { default = "0.0.0.0/0" }

# EIP
variable "enable_elastic_ip" { default = false }

# EC2 Groups Definition
variable "ec2_groups" {
  type = map(object({
    instance_count = number
    instance_type  = string
    volume_size    = number
    ami_id         = string
    os_user        = string
  }))
}