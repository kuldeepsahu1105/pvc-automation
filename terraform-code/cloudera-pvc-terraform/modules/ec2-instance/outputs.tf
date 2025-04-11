# output "instance_ids" {
#   description = "Map of instance group to list of instance IDs"
#   value = {
#     for group, group_values in var.instance_groups :
#     group => [
#       for i in range(group_values.count) :
#       aws_instance.group_instances[group_values.tags.Name].id
#     ]
#   }
# }

# output "private_ips" {
#   description = "Map of instance group to list of private IPs"
#   value = {
#     for group, group_values in var.instance_groups :
#     group => [
#       for i in range(group_values.count) :
#       aws_instance.group_instances[group_values.tags.Name].private_ip
#     ]
#   }
# }

# output "public_ips" {
#   description = "Map of instance group to list of public IPs"
#   value = {
#     for group, group_values in var.instance_groups :
#     group => [
#       for i in range(group_values.count) :
#       aws_instance.group_instances[group_values.tags.Name].public_ip
#     ]
#   }
# }

# output "instance_groups" {
#   description = "Map of instance group to instance group values"
#   value       = var.instance_groups
# }

output "instance_ids" {
  value = {
    for k, instance in aws_instance.group_instances :
    k => instance.id
  }
}

output "private_ips" {
  value = {
    for k, instance in aws_instance.group_instances :
    k => instance.private_ip
  }
}

output "public_ips" {
  value = {
    for k, instance in aws_instance.group_instances :
    k => instance.public_ip
  }
}