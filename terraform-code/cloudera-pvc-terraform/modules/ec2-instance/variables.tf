# Terraform module to support multiple EC2 instance groups with different configurations

variable "common_config" {
  description = "Common config shared by all instances"
  type = object({
    vpc_id            = string
    subnet_id         = string
    security_group_id = string
    key_name          = string
  })
}

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
