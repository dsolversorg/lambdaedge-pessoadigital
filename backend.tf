terraform {
  backend "s3" {
    bucket = "digitalsolvers-terraform-state"
    key    = "prd/lambda-pessoadigital.tfstate"
    region = "us-east-1"
  }
}