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
| [aws_codedeploy_app.codedeploy_app](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/codedeploy_app) | resource |
| [aws_codedeploy_deployment_group.deployment_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/codedeploy_deployment_group) | resource |
| [aws_iam_role.codedeploy_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.codedeploy_role_policy_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_policy_document.assume_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_name"></a> [app\_name](#input\_app\_name) | Name of the CodeDeploy application | `string` | n/a | yes |
| <a name="input_deployment_group_name"></a> [deployment\_group\_name](#input\_deployment\_group\_name) | Name of the CodeDeploy deployment group | `string` | n/a | yes |
| <a name="input_ec2_tag_filter"></a> [ec2\_tag\_filter](#input\_ec2\_tag\_filter) | EC2 tag filter for deployment targeting | <pre>object({<br>    key   = string<br>    type  = string<br>    value = string<br>  })</pre> | n/a | yes |
| <a name="input_vm_role_name"></a> [vm\_role\_name](#input\_vm\_role\_name) | n/a | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_codedeploy_app_name"></a> [codedeploy\_app\_name](#output\_codedeploy\_app\_name) | The name of the CodeDeploy application. |
| <a name="output_codedeploy_deployment_group_name"></a> [codedeploy\_deployment\_group\_name](#output\_codedeploy\_deployment\_group\_name) | The name of the CodeDeploy deployment group. |
