# output "sg_id" {
#   value = aws_security_group.default.id
# }

output "security_group_id" {
  description = "ID of the created security group"
  value       = aws_security_group.vpc_sg[*].id
}
