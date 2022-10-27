include {
  path = find_in_parent_folders()
}

terraform {
  source = "../../../src//s3"
}

locals {
  myvars = read_terragrunt_config(find_in_parent_folders("terragrunt.hcl"))
}

inputs = {
  region              = "ap-south-1"
  environment         = "dev"
  bucket_name         = "codepipeline-artifacts-abhishek"
}