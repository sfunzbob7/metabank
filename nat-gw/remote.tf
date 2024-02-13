data "terraform_remote_state" "metabank-nat" {
  backend = "s3"
  config = {
    bucket = "metabank-terraform-status"
    key    = "metabank/Terraform/vpc/terraform.tfstate"
    region = "ap-northeast-2"
  }
}