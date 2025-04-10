# Placeholder for ec2-instance logic
resource "aws_instance" "this" {
  count         = var.count
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = var.subnet_id
  vpc_security_group_ids = [var.sg_id]

  tags = {
    Name = "${var.instance_name}-${count.index + 1}"
    Environment = var.env_name
    Owner       = var.owner
  }

  associate_public_ip_address = true
}

resource "aws_eip" "eip" {
  count = var.associate_eip ? 1 : 0
  instance = aws_instance.this[0].id
}
