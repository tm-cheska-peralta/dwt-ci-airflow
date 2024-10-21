## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_codepipeline.pipeline](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/codepipeline) | resource |
| [aws_iam_policy_attachment.codepipeline_role_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy_attachment) | resource |
| [aws_iam_role.codepipeline_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy.codepipeline_inline_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_external_s3_bucket"></a> [external\_s3\_bucket](#input\_external\_s3\_bucket) | External S3 bucket to use for storing artifacts | `string` | n/a | yes |
| <a name="input_iam_role_name"></a> [iam\_role\_name](#input\_iam\_role\_name) | Name of the IAM role to be created for CodePipeline | `string` | `"codepipeline-role"` | no |
| <a name="input_pipeline_name"></a> [pipeline\_name](#input\_pipeline\_name) | Name of the CodePipeline | `string` | n/a | yes |
| <a name="input_pipeline_stages"></a> [pipeline\_stages](#input\_pipeline\_stages) | A list of stage configurations for the CodePipeline | <pre>list(object({<br>    name = string<br>    actions = list(object({<br>      name             = string<br>      category         = string<br>      owner            = string<br>      provider         = string<br>      version          = string<br>      input_artifacts  = list(string)<br>      output_artifacts = list(string)<br>      configuration    = map(string)<br>    }))<br>  }))</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_codepipeline_arn"></a> [codepipeline\_arn](#output\_codepipeline\_arn) | The ARN of the CodePipeline |
| <a name="output_codepipeline_name"></a> [codepipeline\_name](#output\_codepipeline\_name) | The name of the CodePipeline |
