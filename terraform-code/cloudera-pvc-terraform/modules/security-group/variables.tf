variable "vpc_id" {}
variable "allowed_ports" {
  type = list(number)
}
variable "allowed_cidr" {}
variable "env_name" {}
variable "owner" {}
