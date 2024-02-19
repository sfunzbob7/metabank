data "terraform_remote_state" "metabank-eks" {
  backend = "s3"
  config = {
    bucket = "metabank-terraform-status"
    key    = "metabank/Terraform/vpc/terraform.tfstate"
    region = "ap-northeast-2"
  }
}

data "terraform_remote_state" "metabank-sg" {
  backend = "s3"
  config = {
    bucket = "metabank-terraform-status"
    key    = "metabank/Terraform/sg/terraform.tfstate"
    region = "ap-northeast-2"
  }
}
