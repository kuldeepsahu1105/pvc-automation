resource "aws_s3_bucket" "tf_state" {
  bucket = var.bucket_name
  versioning {
    enabled = true
  }
  lifecycle {
    prevent_destroy = true
  }
  tags = merge(
    var.s3_backend_tags,
    {
      "created_by" = "Terraform"
    }
  )
}

resource "aws_dynamodb_table" "tf_lock" {
  name         = var.dynamodb_table_name
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
  tags = merge(
    var.s3_backend_tags,
    {
      "created_by" = "Terraform"
    }
  )
}
