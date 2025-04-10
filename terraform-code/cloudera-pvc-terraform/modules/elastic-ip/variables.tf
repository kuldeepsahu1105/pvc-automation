# variable "enable_elastic_ip" {
#   type = bool
# }

variable "create_eip"{
  description = "True or false to create Elastic IP"
  type        = bool
}

variable "eip_name" {
  description = "Name tag to assign to the Elastic IP"
  type        = string
}

variable "eip_tags" {
  description = "Map of tags to apply to the key pair (owner and environment)"
  type        = map(string)
  default = {
    "owner"       = "kashu-ygulati"
    "environment" = "your-environment"
  }
}
