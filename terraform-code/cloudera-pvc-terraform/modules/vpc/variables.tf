# variable "create_vpc" {}
# variable "vpc_name" {}
# variable "vpc_cidr" {}
# variable "availability_zones" {
#   type = list(string)
# }
# variable "public_subnets" {
#   type = list(string)
# }
# variable "private_subnets" {
#   type = list(string)
# }
# variable "enable_nat_gateway" {}
# variable "env_name" {}
# variable "owner" {}

variable "create_vpc" {
  description = "Whether to create a new VPC or use the default one"
  type        = bool
  default     = false
}

variable "vpc_name" {
  description = "Name of new VPC or use the default one"
  type        = string
  default     = "my-vpc"
}

variable "vpc_tags" {
  description = "Map of tags to apply to the key pair (owner and environment)"
  type        = map(string)
  default = {
    "owner"       = "your-owner"
    "environment" = "your-environment"
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

variable "private_subnets" {
  type = list(string)
  default = []
}

variable "public_subnets" {
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

variable "tags" {
  type    = map(string)
  default = {}
}
