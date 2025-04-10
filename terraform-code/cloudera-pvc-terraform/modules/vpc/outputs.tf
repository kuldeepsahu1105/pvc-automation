# output "vpc_id" {
#   value = module.vpc.vpc_id
# }

# output "subnet_ids" {
#   value = module.vpc.public_subnets
# }

# output "private_subnet_ids" {
#   value = module.vpc.private_subnets
# }

output "vpc_id" {
  value = var.create_vpc ? module.vpc[0].vpc_id : data.aws_vpc.default[0].id
}

output "subnet_ids" {
  value = var.create_vpc ? concat(module.vpc[0].public_subnets, module.vpc[0].private_subnets) : data.aws_subnets.default[0].ids
}
