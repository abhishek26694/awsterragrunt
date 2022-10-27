terraform {
  required_version = ">= 1.0.0"
}

provider "aws" {
  region = var.region
}

module "codepipeline" {
  source                         = "../resources//pipeline"
  environment                    = var.environment
  compute_type                   = var.compute_type
  image                          = var.image
  dockerhub_credentials          = var.dockerhub_credentials
  codestar_connector_credentials = var.codestar_connector_credentials
  full_repository_id             = var.full_repository_id
  branch_name                    = var.branch_name
  tfcodebuildiamrole             = var.tfcodebuildiamrole
  tfcodepipelineiamrole          = var.tfcodepipelineiamrole
  codepipelineartifactsbucket    = var.codepipelineartifactsbucket

}
