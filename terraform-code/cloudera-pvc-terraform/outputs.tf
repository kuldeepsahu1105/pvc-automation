# output "vpc_id" {
#   value = module.vpc.vpc_id
# }

# output "public_subnets" {
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
      module.multi_ec2.instance_ids["${group}-${i + 1}"]
    ]
  }
}

output "private_ips" {
  description = "Map of instance group to list of private IPs"
  value = {
    for group, group_values in var.instance_groups :
    group => [
      for i in range(group_values.count) :
      module.multi_ec2.private_ips["${group}-${i + 1}"]
    ]
  }
}

output "public_ips" {
  description = "Map of instance group to list of public IPs"
  value = {
    for group, group_values in var.instance_groups :
    group => [
      for i in range(group_values.count) :
      module.multi_ec2.public_ips["${group}-${i + 1}"]
    ]
  }
}

output "instance_groups" {
  description = "Map of instance group to instance group values"
  value       = var.instance_groups
}
