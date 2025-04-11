
# # output "instance_groups" {
# #   description = "Map of instance group to instance group values"
# #   value       = var.instance_groups
# # }

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
