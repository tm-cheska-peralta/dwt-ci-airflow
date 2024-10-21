# AWS Security Groups Terraform Module

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
| [aws_security_group.database](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group_rule.database_in](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.database_out](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.private_in](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.private_out](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.public_in_http](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.public_in_https](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.public_in_ssh](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.public_out](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_database_cidr_blocks"></a> [database\_cidr\_blocks](#input\_database\_cidr\_blocks) | n/a | `list(string)` | <pre>[<br>  "0.0.0.0/0"<br>]</pre> | no |
| <a name="input_database_sg_name"></a> [database\_sg\_name](#input\_database\_sg\_name) | n/a | `string` | n/a | yes |
| <a name="input_database_sg_tags"></a> [database\_sg\_tags](#input\_database\_sg\_tags) | n/a | `map(string)` | `{}` | no |
| <a name="input_private_cidr_blocks"></a> [private\_cidr\_blocks](#input\_private\_cidr\_blocks) | Place here the VPC CIDR block. | `list(string)` | n/a | yes |
| <a name="input_private_sg_name"></a> [private\_sg\_name](#input\_private\_sg\_name) | n/a | `string` | n/a | yes |
| <a name="input_private_sg_tags"></a> [private\_sg\_tags](#input\_private\_sg\_tags) | n/a | `map(string)` | `{}` | no |
| <a name="input_public_cidr_blocks"></a> [public\_cidr\_blocks](#input\_public\_cidr\_blocks) | n/a | `list(string)` | <pre>[<br>  "0.0.0.0/0"<br>]</pre> | no |
| <a name="input_public_sg_name"></a> [public\_sg\_name](#input\_public\_sg\_name) | n/a | `string` | n/a | yes |
| <a name="input_public_sg_tags"></a> [public\_sg\_tags](#input\_public\_sg\_tags) | n/a | `map(string)` | `{}` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | n/a | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_security_group_database"></a> [security\_group\_database](#output\_security\_group\_database) | n/a |
| <a name="output_security_group_private"></a> [security\_group\_private](#output\_security\_group\_private) | n/a |
| <a name="output_security_group_public"></a> [security\_group\_public](#output\_security\_group\_public) | n/a |
