data "aws_iam_role" "tfcodebuildiamrole" {
  name = var.tfcodebuildiamrole
}

data "aws_iam_role" "tfcodepipelineiamrole" {
  name = var.tfcodepipelineiamrole
}


data "aws_s3_bucket" "codepipelineartifactsbucket" {
  bucket = var.codepipelineartifactsbucket
}


resource "aws_codebuild_project" "tf-plan" {
  name          = "tf-cicd-plan-${var.environment}"
  description   = "Plan stage for terraform"
  service_role  = data.aws_iam_role.tfcodebuildiamrole.arn

  artifacts {
    type = "CODEPIPELINE"
  }

  environment {
    compute_type                = var.compute_type
    image                       = var.image
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "SERVICE_ROLE"
    registry_credential{
        credential = var.dockerhub_credentials
        credential_provider = "SECRETS_MANAGER"
    }
 }
 source {
     type   = "CODEPIPELINE"
     buildspec = file("../../buildspec//plan-buildspec.yml")
 }
}

resource "aws_codebuild_project" "tf-apply" {
  name          = "tf-cicd-apply-${var.environment}"
  description   = "Apply stage for terraform"
  service_role  = data.aws_iam_role.tfcodebuildiamrole.arn

  artifacts {
    type = "CODEPIPELINE"
  }

  environment {
    compute_type                = var.compute_type
    image                       = var.image
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "SERVICE_ROLE"
    registry_credential{
        credential = var.dockerhub_credentials
        credential_provider = "SECRETS_MANAGER"
    }
 }
 source {
     type   = "CODEPIPELINE"
     buildspec = file("../../buildspec//apply-buildspec.yml")
 }
}


resource "aws_codepipeline" "cicd_pipeline" {

    name = "tf-cicd-${var.environment}"
    role_arn = data.aws_iam_role.tfcodepipelineiamrole.arn

    artifact_store {
        type="S3"
        location = data.aws_s3_bucket.codepipelineartifactsbucket.id  
    }

    stage {
        name = "Source"
        action{
            name = "Source"
            category = "Source"
            owner = "AWS"
            provider = "CodeStarSourceConnection"
            version = "1"
            output_artifacts = ["tf-code"]
            configuration = {
                FullRepositoryId = var.full_repository_id
                BranchName   = var.branch_name
                ConnectionArn = var.codestar_connector_credentials
                OutputArtifactFormat = "CODE_ZIP"
            }
        }
    }

    stage {
        name ="Plan"
        action{
            name = "Build"
            category = "Build"
            provider = "CodeBuild"
            version = "1"
            owner = "AWS"
            input_artifacts = ["tf-code"]
            configuration = {
                ProjectName = "tf-cicd-plan"
            }
        }
    }

    stage {
        name ="Deploy"
        action{
            name = "Deploy"
            category = "Build"
            provider = "CodeBuild"
            version = "1"
            owner = "AWS"
            input_artifacts = ["tf-code"]
            configuration = {
                ProjectName = "tf-cicd-apply"
            }
        }
    }

}