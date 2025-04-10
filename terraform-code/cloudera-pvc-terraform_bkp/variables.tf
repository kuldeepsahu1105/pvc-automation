variable "env_name" { type = string }
variable "owner" { type = string }

variable "pvcbase_master_count" { type = number default = 1 }
variable "pvcbase_worker_count" { type = number default = 6 }
variable "pvcecs_master_count" { type = number default = 1 }
variable "pvcecs_worker_count" { type = number default = 10 }

variable "create_elastic_ip" { type = bool default = false }
variable "create_custom_vpc" { type = bool default = false }
variable "custom_vpc_subnets" { type = number default = 2 }
variable "allowed_cidr" { type = string default = "0.0.0.0/0" }
