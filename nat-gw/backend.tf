# backend
terraform {
  backend "s3" {
    bucket = "metabank-terraform-status"
    key    = "metabank/Terraform/nat-gw/terraform.tfstate"
    region = "ap-northeast-2"

    dynamodb_table = "metabank-terraform-locks"
    encrypt        = true
  }
}
