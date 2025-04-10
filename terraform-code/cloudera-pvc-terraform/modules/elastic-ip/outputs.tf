# output "eip" {
#   value = var.enable_elastic_ip ? aws_eip.this[0].public_ip : null
# }

output "eip_public_ip" {
  description = "The public IP address of the Elastic IP"
  value       = aws_eip.this[0].public_ip
}

