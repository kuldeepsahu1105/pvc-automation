bucket_name         = "pvc-cluster-terraform-backend"
dynamodb_table_name = "pvc-terraform-lock-table"
environment         = "dev"
aws_region          = "ap-southeast-1"
s3_backend_tags = {
  owner       = "ksahu-ygulati" # Set your owner tag
  environment = "development"   # Set your environment tag
}
