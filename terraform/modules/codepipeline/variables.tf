variable "pipeline_name" {
  description = "Name of the CodePipeline"
  type        = string
}

variable "external_s3_bucket" {
  description = "External S3 bucket to use for storing artifacts"
  type        = string
}

variable "iam_role_name" {
  description = "Name of the IAM role to be created for CodePipeline"
  type        = string
  default     = "codepipeline-role"
}

variable "pipeline_stages" {
  description = "A list of stage configurations for the CodePipeline"
  type = list(object({
    name = string
    actions = list(object({
      name             = string
      category         = string
      owner            = string
      provider         = string
      version          = string
      input_artifacts  = list(string)
      output_artifacts = list(string)
      configuration    = map(string)
    }))
  }))
}
