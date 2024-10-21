variable "app_name" {
  type        = string
  description = "Name of the CodeDeploy application"
}

variable "deployment_group_name" {
  type        = string
  description = "Name of the CodeDeploy deployment group"
}

variable "ec2_tag_filter" {
  type = object({
    key   = string
    type  = string
    value = string
  })
  description = "EC2 tag filter for deployment targeting"
}

variable "vm_role_name" {
  type = string
}