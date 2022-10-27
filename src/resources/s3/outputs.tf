output "codepipeline_artifacts_arn" {
  description = "Arn of aws lambda function role"
  value       = aws_s3_bucket.codepipeline_artifacts.arn
}