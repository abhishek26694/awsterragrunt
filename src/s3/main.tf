terraform {
  required_version = ">= 1.0.0"
}

provider "aws" {
    region = "ap-south-1"
}

module "s3" {
  source                      = "../resources//s3"
  bucket_name                 = var.bucket_name
  environment                 = var.environment
}