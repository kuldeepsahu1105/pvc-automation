resource "aws_eip" "this" {
  count = var.enable_elastic_ip ? 1 : 0
  vpc   = true
}
