# Placeholder for ec2-instance logic

resource "aws_instance" "group_instances" {
  for_each = var.instance_groups

  count                  = each.value.count
  ami                    = each.value.ami
  instance_type          = each.value.instance_type
  key_name               = var.common_config.key_name
  subnet_id              = var.common_config.subnet_id
  vpc_security_group_ids = [var.common_config.security_group_id]
  user_data              = lookup(each.value, "user_data", null)

  root_block_device {
    volume_size = each.value.volume_size
    volume_type = "gp3"
  }

  tags = merge(each.value.tags, {
    Group = each.key
  })

  # tags = {
  #   Name = "${var.instance_name}-${count.index + 1}"
  #   Environment = var.env_name
  #   Owner       = var.owner
  # }

  associate_public_ip_address = true
}

# Multiple EC2 Instance
module "ec2_instance" {
  source = "terraform-aws-modules/ec2-instance/aws"

  for_each = toset(["one", "two", "three"])

  name = "instance-${each.key}"

  instance_type          = "t2.micro"
  key_name               = "user1"
  monitoring             = true
  vpc_security_group_ids = ["sg-12345678"]
  subnet_id              = "subnet-eddcdzz4"

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}


# Example EC2 instance with the created or existing key pair
# resource "aws_instance" "example" {
#   ami           = var.ami_id
#   instance_type = var.instance_type
#   key_name      = local.pvc_cluster_keypair

#   tags = {
#     Name = "ExampleEC2Instance"
#   }
# }