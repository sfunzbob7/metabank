data "terraform_remote_state" "metabank-ec2-sg" {
  backend = "s3"
  config = {
    bucket = "metabank-terraform-status"
    key    = "metabank/Terraform/sg/terraform.tfstate"
    region = "ap-northeast-2"
  }
}

data "terraform_remote_state" "metabank-ec2-vpc" {
  backend = "s3"
  config = {
    bucket = "metabank-terraform-status"
    key    = "metabank/Terraform/vpc/terraform.tfstate"
    region = "ap-northeast-2"
  }
}