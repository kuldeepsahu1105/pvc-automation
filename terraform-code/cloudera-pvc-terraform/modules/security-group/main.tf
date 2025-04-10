# resource "aws_security_group" "default" {
#   name        = "cloudera-sg"
#   description = "Security group for Cloudera PVC instances"
#   vpc_id      = var.vpc_id

#   dynamic "ingress" {
#     for_each = var.allowed_ports
#     content {
#       from_port   = ingress.value
#       to_port     = ingress.value
#       protocol    = "tcp"
#       cidr_blocks = [var.allowed_cidr]
#     }
#   }

#   dynamic "egress" {
#     for_each = var.allowed_ports
#     content {
#       from_port   = egress.value
#       to_port     = egress.value
#       protocol    = "tcp"
#       cidr_blocks = ["0.0.0.0/0"]
#     }
#   }

#   tags = {
#     Name        = "cloudera-sg"
#     Environment = var.env_name
#     Owner       = var.owner
#   }
# }

locals {
  # Flag to determine if keypair should be created
  create_new_sg = var.create_new_sg == "true" ? true : false

  # Key pair value
  pvc_cluster_sg = (
    local.create_new_sg == false ?
    var.existing_sg :                  # Use existing key pair name provided by user
    aws_security_group.vpc_sg[0].name # Otherwise, create a new key pair
  )
}

data "aws_security_group" "existing_sg" {
  count    = local.create_new_sg == false ? 1 : 0
  id = var.existing_sg
}

resource "aws_security_group" "vpc_sg" {
  count       = local.create_new_sg ? 1 : 0  # Only create a new security group if the flag is true
  name        = var.sg_name
  description = var.sg_description
  vpc_id      = var.vpc_id

  lifecycle {
    create_before_destroy = true
  }

  # Loop only through ports
  dynamic "ingress" {
    for_each = var.allowed_ports
    content {
      description = "Allow traffic on port ${ingress.value}"
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = var.allowed_cidrs
    }
  }

  # Internal traffic rule
  ingress {
    description = "Allow all internal VPC traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    self = true
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = var.sg_tags
}

