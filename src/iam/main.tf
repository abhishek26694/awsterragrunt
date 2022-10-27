terraform {
  required_version = ">= 1.0.0"
}

provider "aws" {
  region = var.region
}

/* Create IAM ROLE to restrict creation of ec2 instances outside of IAM */
module "iam" {
  source               = "../resources//iam"
  environment          = var.environment
}
