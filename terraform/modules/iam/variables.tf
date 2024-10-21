variable "vm_role_name" {
  type = string
}

variable "instance_profile_name" {
  type = string
}

variable "vm_execution_policy_name" {
  type = string
}

variable "tags" {
  type = map(string)
}

variable "s3_buckets_arn" {
  description = "List of S3 buckets to give EC2 access."
  type = list(string)
}

variable "s3_bucket_objects_arn" {
  description = "Give EC2 access to all objects inside bucket. Ex: [\"bucket-arn/*\"]"
  type = list(string)
}