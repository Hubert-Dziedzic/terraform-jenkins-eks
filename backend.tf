terraform {
  backend "s3" {
    bucket = "hd99-terraform-remote-state"
    key    = "jenkins/terraform.tfstate"
    region = "eu-west-3"
  }
}