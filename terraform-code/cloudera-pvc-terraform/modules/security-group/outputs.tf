# output "sg_id" {
#   value = aws_security_group.default.id
# }

output "security_group_id" {
  description = "ID of the created security group"
  value       = var.create_new_sg == true ? aws_security_group.vpc_sg[*].id : null
}

output "existing_sg_name" {
  value       = var.create_new_sg == false ? data.aws_security_group.existing_sg[*].name : null
  description = "Key pair name used when create_keypair is false"
}
