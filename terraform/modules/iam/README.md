# AWS IAM Module

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
| [aws_iam_instance_profile.vm_profile](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_instance_profile) | resource |
| [aws_iam_policy.vm_execution_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.vm_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.s3_execution_policy_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.vm_aws_managed_policy_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_policy_document.staging_bucket_access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.vm_execution_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_instance_profile_name"></a> [instance\_profile\_name](#input\_instance\_profile\_name) | n/a | `string` | n/a | yes |
| <a name="input_s3_bucket_objects_arn"></a> [s3\_bucket\_objects\_arn](#input\_s3\_bucket\_objects\_arn) | Give EC2 access to all objects inside bucket. Ex: ["bucket-arn/*"] | `list(string)` | n/a | yes |
| <a name="input_s3_buckets_arn"></a> [s3\_buckets\_arn](#input\_s3\_buckets\_arn) | List of S3 buckets to give EC2 access. | `list(string)` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map(string)` | n/a | yes |
| <a name="input_vm_execution_policy_name"></a> [vm\_execution\_policy\_name](#input\_vm\_execution\_policy\_name) | n/a | `string` | n/a | yes |
| <a name="input_vm_role_name"></a> [vm\_role\_name](#input\_vm\_role\_name) | n/a | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_instance_profile_name"></a> [instance\_profile\_name](#output\_instance\_profile\_name) | n/a |
| <a name="output_vm_role"></a> [vm\_role](#output\_vm\_role) | n/a |
