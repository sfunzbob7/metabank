# backend
terraform {
  backend "s3" {
    bucket = "metabank-terraform-status"
    key    = "metabank/Terraform/sg/terraform.tfstate"
    region = "ap-northeast-2"

    dynamodb_table = "metabank-terraform-locks"
    encrypt        = true
  }
}
