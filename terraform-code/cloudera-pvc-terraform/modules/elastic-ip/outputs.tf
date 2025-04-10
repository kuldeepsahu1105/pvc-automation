
output "eip_public_ip" {
  description = "The public IP address of the Elastic IP"
  value       = var.create_eip ? aws_eip.this[*].public_ip : null
}

