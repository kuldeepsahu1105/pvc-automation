variable "create_vpc" {}
variable "vpc_name" {}
variable "vpc_cidr" {}
variable "availability_zones" {
  type = list(string)
}
variable "public_subnets" {
  type = list(string)
}
variable "private_subnets" {
  type = list(string)
}
variable "enable_nat_gateway" {}
variable "env_name" {}
variable "owner" {}
