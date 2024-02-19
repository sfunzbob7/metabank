data "terraform_remote_state" "metabank-node-eks" {
  backend = "s3"
  config = {
    bucket = "metabank-terraform-status"
    key    = "metabank/Terraform/eks/terraform.tfstate"
    region = "ap-northeast-2"
  }
}

data "terraform_remote_state" "metabank-node-vpc" {
  backend = "s3"
  config = {
    bucket = "metabank-terraform-status"
    key    = "metabank/Terraform/vpc/terraform.tfstate"
    region = "ap-northeast-2"
  }
}
