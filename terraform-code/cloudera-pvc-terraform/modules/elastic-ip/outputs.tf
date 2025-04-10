output "eip" {
  value = var.enable_elastic_ip ? aws_eip.this[0].public_ip : null
}
