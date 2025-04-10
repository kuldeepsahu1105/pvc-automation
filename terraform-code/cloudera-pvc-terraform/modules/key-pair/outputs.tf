# output "instance_public_ip" {
#   description = "Public IP of the created EC2 instance"
#   value       = aws_instance.example.public_ip
# }

output "keypair_name" {
  description = "The key pair name used for the EC2 instance"
  value       = local.pvc_cluster_keypair
}

output "existing_keypair_name" {
  value = var.create_keypair ? "false" : data.aws_key_pair.existing_keypair[*].name
  description = "Key pair name used when create_keypair is false"
}
