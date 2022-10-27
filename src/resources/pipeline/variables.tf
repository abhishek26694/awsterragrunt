variable "environment" {
      type = string
}

variable "compute_type" {
      type = string
}

variable "image" {
      type = string
}

variable "dockerhub_credentials" {
      type = string
}

variable "codestar_connector_credentials" {
      type = string
}

variable "full_repository_id" {
      type = string
}

variable "branch_name" {
      type = string
}
variable "tfcodebuildiamrole"{}

variable "tfcodepipelineiamrole"{}

variable "codepipelineartifactsbucket"{}