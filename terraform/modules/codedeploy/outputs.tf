output "codedeploy_app_name" {
  value       = aws_codedeploy_app.codedeploy_app.name
  description = "The name of the CodeDeploy application."
}

output "codedeploy_deployment_group_name" {
  value       = aws_codedeploy_deployment_group.deployment_group.deployment_group_name
  description = "The name of the CodeDeploy deployment group."
}