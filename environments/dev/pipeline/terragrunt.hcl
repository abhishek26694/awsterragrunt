include {
  path = find_in_parent_folders()
}

terraform {
  source = "../../../src//pipeline"
}

locals {
  myvars = read_terragrunt_config(find_in_parent_folders("terragrunt.hcl"))
}

inputs = {
  region                         = "ap-south-1"
  environment                    = "dev"
  compute_type                   = "BUILD_GENERAL1_SMALL"
  image                          = "cytopia/terragrunt"
  dockerhub_credentials          = "arn:aws:secretsmanager:ap-south-1:127023262838:secret:codebuild-dockerhub-0DxqVl"
  codestar_connector_credentials = "arn:aws:codestar-connections:ap-south-1:127023262838:connection/7fbdf34c-32e3-4400-9fac-34198600fb15"
  full_repository_id             = "abhishek26694/awsterraform"
  branch_name                    = "master"
}