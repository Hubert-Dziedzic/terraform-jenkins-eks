terraform {
  backend "s3" {
    bucket = "hd99-terraform-remote-state"
    key    = "eks/terraform.tfstate"
    region = "eu-west-3"
  }
}