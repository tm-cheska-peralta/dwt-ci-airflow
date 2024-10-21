module "codedeploy" {
  source = "../modules/codedeploy"

  app_name = var.app_name
  deployment_group_name = var.deployment_group_name
  ec2_tag_filter = var.ec2_tag_filter
  vm_role_name = local.vm_role_name
}

resource "aws_codestarconnections_connection" "codestarconnections_connection" {
  name          = var.github_connection_name
  provider_type = "GitHub"
}

module "codepipeline" {
  source = "../modules/codepipeline"

  pipeline_name = var.pipeline_name
  external_s3_bucket = module.staging_bucket.bucket
  pipeline_stages = [ 
    {
      name    = "Source"
      actions = [
        {
          name             = "Source"
          category         = "Source"
          owner            = "AWS"
          provider         = "CodeStarSourceConnection"
          version          = "1"
          input_artifacts  = []
          output_artifacts = ["source_output"]
          configuration = {
            ConnectionArn    = aws_codestarconnections_connection.codestarconnections_connection.arn
            FullRepositoryId = var.github_repo_id
            BranchName       = var.github_repo_branch
          }
        }
      ]
    },
    {
      name    = "Deploy"
      actions = [
        {
          name             = "Deploy"
          category         = "Deploy"
          owner            = "AWS"
          provider         = "CodeDeploy"
          version          = "1"
          input_artifacts  = ["source_output"]
          output_artifacts = []
          configuration = {
            ApplicationName     = module.codedeploy.codedeploy_app_name
            DeploymentGroupName = module.codedeploy.codedeploy_deployment_group_name
          }
        }
      ]
    } 
  ]
}