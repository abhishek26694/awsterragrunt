# Determine our environment name from the folder name
locals {
    region = "ap-south-1"
    owner = "Abhishek"
    product = "generic"
}

inputs = {}

# Remote state stored in Amazon S3
remote_state {
  backend = "s3"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
  config = {
    bucket = "1666766181-awsterraform-state"  
    key = "envs/${replace(path_relative_to_include(), "environments/", "")}/terraform.tfstate"
    region         = "ap-south-1"
    encrypt        = true
  }
}