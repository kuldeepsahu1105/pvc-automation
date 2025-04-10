terraform {
  backend "s3" {
    bucket         = "pvc-cluster-terraform-backend" # Replace with your S3 bucket name
    dynamodb_table = "pvc-terraform-lock-table"
    key            = "pvc_setup/terraform.tfstate" # Path where the state file will be stored inside the bucket
    region         = "ap-southeast-1"              # AWS region of the S3 bucket  # Set appropriate ACL for the state file
  }
}

provider "aws" {
  region = var.region
}
