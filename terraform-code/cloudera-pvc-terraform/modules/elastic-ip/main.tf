# resource "aws_eip" "this" {
#   count = var.enable_elastic_ip ? 1 : 0
#   vpc   = true
# }

resource "aws_eip" "this" {
  count = var.create_eip == true ? 1 : 0
  vpc   = true

  tags = merge(
    var.eip_tags,
    {
      "Name"      = var.eip_name,
      "CreatedBy" = "Terraform"
    }
  )
}
