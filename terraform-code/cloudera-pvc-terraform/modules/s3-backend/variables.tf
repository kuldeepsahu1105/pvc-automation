variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "ap-southeast-1"
}

variable "bucket_name" {
  description = "Name of the S3 bucket to store Terraform state"
  type        = string
}

variable "dynamodb_table_name" {
  description = "Name of the DynamoDB table for state locking"
  type        = string
}

variable "environment" {
  description = "Environment tag for resources"
  type        = string
  default     = "dev"
}

variable "s3_backend_tags" {
  description = "Map of tags to apply to the key pair (owner and environment)"
  type        = map(string)
  default = {
    "owner"       = "your-owner"
    "environment" = "your-environment"
  }
}
