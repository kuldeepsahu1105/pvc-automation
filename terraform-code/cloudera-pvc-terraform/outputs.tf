output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnets" {
  value = module.vpc.subnet_ids
}

output "key_name" {
  value = module.key_pair.key_name
}

output "elastic_ip" {
  value = module.elastic_ip.eip
}