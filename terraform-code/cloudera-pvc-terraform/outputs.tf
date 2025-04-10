# output "vpc_id" {
#   value = module.vpc.vpc_id
# }

# output "public_subnets" {
#   value = module.vpc.subnet_ids
# }

# output "key_name" {
#   value = module.key_pair.key_name
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
