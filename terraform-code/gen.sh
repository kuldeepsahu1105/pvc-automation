#!/bin/bash

set -e

ROOT_DIR="cloudera-pvc-terraform"
MODULES=(ec2-instance key-pair security-group elastic-ip vpc)
MAIN_FILES=(main.tf variables.tf outputs.tf provider.tf terraform.tfvars)

echo "Creating root directory: $ROOT_DIR"
mkdir -p "$ROOT_DIR/modules"

cd "$ROOT_DIR"

# Create root Terraform files
echo "Creating root files..."
for file in "${MAIN_FILES[@]}"; do
  touch "$file"
done

# Create modules
echo "Creating module directories and files..."
for module in "${MODULES[@]}"; do
  mkdir -p "modules/$module"
  touch "modules/$module/main.tf" "modules/$module/variables.tf" "modules/$module/outputs.tf"
done

echo "Writing code to files..."

# ========== PROVIDER ==========
cat > provider.tf <<EOF
provider "aws" {
  region = var.aws_region
}
EOF

# ========== VARIABLES ==========
cat > variables.tf <<'EOF'
variable "aws_region" {}
variable "env_name" {}
variable "owner" {}

variable "key_pair_name" { default = "" }
variable "create_key_pair" {
  description = "If true, a new key pair will be generated."
  default     = false
}

# Configuration per group
variable "cldr_mngr_ami" {}
variable "cldr_mngr_instance_type" {}
variable "cldr_mngr_volume_size" {}

variable "freeipa_ami" {}
variable "freeipa_instance_type" {}
variable "freeipa_volume_size" {}

variable "pvcbase_master_ami" {}
variable "pvcbase_master_instance_type" {}
variable "pvcbase_master_volume_size" {}

variable "pvcbase_worker_ami" {}
variable "pvcbase_worker_instance_type" {}
variable "pvcbase_worker_volume_size" {}

variable "pvcecs_master_ami" {}
variable "pvcecs_master_instance_type" {}
variable "pvcecs_master_volume_size" {}

variable "pvcecs_worker_ami" {}
variable "pvcecs_worker_instance_type" {}
variable "pvcecs_worker_volume_size" {}
EOF

# ========== MODULE: key-pair ==========
cat > modules/key-pair/variables.tf <<'EOF'
variable "create_key_pair" {
  type    = bool
  default = false
}

variable "key_pair_name" {
  type    = string
  default = ""
}
EOF

cat > modules/key-pair/main.tf <<'EOF'
resource "tls_private_key" "default" {
  count      = var.create_key_pair ? 1 : 0
  algorithm  = "RSA"
  rsa_bits   = 4096
}

resource "aws_key_pair" "generated" {
  count      = var.create_key_pair ? 1 : 0
  key_name   = var.key_pair_name != "" ? var.key_pair_name : "cloudera-key"
  public_key = tls_private_key.default[0].public_key_openssh
}

resource "local_file" "private_key" {
  count    = var.create_key_pair ? 1 : 0
  content  = tls_private_key.default[0].private_key_pem
  filename = "./${var.key_pair_name != "" ? var.key_pair_name : "cloudera-key"}.pem"
  file_permission = "0400"
}
EOF

cat > modules/key-pair/outputs.tf <<'EOF'
output "key_pair_name" {
  value = var.create_key_pair ? aws_key_pair.generated[0].key_name : var.key_pair_name
}
EOF

# ========== MODULE: ec2-instance ==========
cat > modules/ec2-instance/variables.tf <<'EOF'
variable "instance_name" {}
variable "count" {}
variable "ami_id" {}
variable "instance_type" {}
variable "volume_size" {}
variable "key_name" {}
variable "sg_id" {}
variable "subnet_id" {}
variable "env_name" {}
variable "owner" {}
EOF

cat > modules/ec2-instance/main.tf <<'EOF'
resource "aws_instance" "this" {
  count                       = var.count
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = [var.sg_id]
  key_name                    = var.key_name
  associate_public_ip_address = true

  root_block_device {
    volume_size = var.volume_size
    volume_type = "gp3"
  }

  tags = {
    Name        = "${var.instance_name}-${count.index + 1}"
    Environment = var.env_name
    Owner       = var.owner
  }
}
EOF

cat > modules/ec2-instance/outputs.tf <<'EOF'
output "instance_ids" {
  value = aws_instance.this[*].id
}
EOF

echo "✅ All Terraform files and folders have been created."
