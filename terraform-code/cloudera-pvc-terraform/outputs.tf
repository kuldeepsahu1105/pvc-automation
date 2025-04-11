# output "vpc_id" {
#   value = module.vpc.vpc_id
# }

# output "public_subnets_cidr" {
#   value = module.vpc.subnet_ids
# }

# output "elastic_ip" {
#   value = module.elastic_ip.eip
# }


output "keypair_name" {
  value = module.key-pair.keypair_name
}

output "cldr_mngr_public_ip" {
  value       = module.elastic-ip.eip_public_ip
  description = "The public IP of the Elastic IP created for the cloudera manager"
}

output "instance_ids" {
  description = "Map of instance group to list of instance IDs"
  value = {
    for group, group_values in var.instance_groups :
    group => [
      for i in range(group_values.count) :
      module.ec2-instance.instance_ids["${group}-${i + 1}"]
    ]
  }
}

output "private_ips" {
  description = "Map of instance group to list of private IPs"
  value = {
    for group, group_values in var.instance_groups :
    group => [
      for i in range(group_values.count) :
      module.ec2-instance.private_ips["${group}-${i + 1}"]
    ]
  }
}

output "public_ips" {
  description = "Map of instance group to list of public IPs"
  value = {
    for group, group_values in var.instance_groups :
    group => [
      for i in range(group_values.count) :
      module.ec2-instance.public_ips["${group}-${i + 1}"]
    ]
  }
}

output "instance_groups" {
  description = "Map of instance group to instance group values"
  value       = var.instance_groups
}

# output "vpc_id" {
#   value = var.create_vpc ? module.vpc[0].vpc_id : module.vpc.default[*].id
# }

# output "subnet_ids" {
#   value = var.create_vpc ? concat(module.vpc[0].public_subnets_cidr, module.vpc[0].private_subnets_cidr) : module.vpc.subnet_ids
# }

# output "vpc_name" {
#   description = "The vpc name used for the EC2 instance"
#   value       = var.create_vpc == true ? module.vpc.vpc_name : null
# }

# output "default_vpc_name" {
#   description = "Default vpc name used when create_vpc is false"
#   value       = var.create_vpc == false ? module.vpc.default_vpc_name : null
# }
