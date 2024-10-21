variable "instance_type" {
  type = string
}

variable "associate_public_ip_address" {
  type    = bool
  default = false
}

variable "vm_name" {
  type = string
}

variable "environment" {
  type = string
}

variable "subnet_id" {
  type = any
}

variable "vpc_security_group_ids" {
  type = list(string)
}

variable "iam_instance_profile" {
  type = string
}

variable "tags" {
  type    = any
  default = null
}

variable "user_data" {
  type    = string
  default = null
}