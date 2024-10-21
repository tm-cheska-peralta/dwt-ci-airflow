# Global Config
variable "region" {
  type = string
}

variable "tag_creator" {
  type = string
}

variable "profile" {
  type = string
}

variable "environment" {
  type = string
}

# VPC
variable "vpc_name" {
  type = string
}

variable "vpc_cidr" {
  type = string
}

variable "vpc_azs" {
  type = list(string)
}

variable "vpc_database_subnets" {
  type = list(string)
}

variable "vpc_private_subnets" {
  type = list(string)
}

variable "vpc_public_subnets" {
  type = list(string)
}

variable "enable_nat_gateway" {
  type    = bool
  default = true
}

variable "enable_flow_log" {
  type    = bool
  default = false
}

variable "flow_log_destination_arn" {
  type    = string
  default = ""
}

# S3
variable "flow_logs_bucket_name" {
  type = string
}

variable "bucket_name" {
  type = string
}

# Virtual Machine / EC2
variable "vm_name" {
  type = string
}

variable "instance_type" {
  type = string
}

variable "user_data" {
  type = any
}

# RDS
variable "identifier" {
  type = string
}

variable "instance_class" {
  type = string
}

variable "db_name" {
  type = string
}

variable "db_username" {
  type = string
}

variable "db_password" {
  type      = string
  sensitive = true
}

variable "port" {
  type = number
}

variable "engine" {
  type = string
}

variable "engine_version" {
  type = string
}

variable "family" {
  type = string
}

variable "allocated_storage" {
  type = number
}

variable "max_allocated_storage" {
  type = number
}

variable "storage_encrypted" {
  type = bool
}

variable "deletion_protection" {
  type = bool
}

variable "skip_final_snapshot" {
  type = bool
}

variable "final_snapshot_identifier" {
  description = "Must be provided if skip_final_snapshot is set to false"
  type        = string
  default     = "snapshot"
}# Cloud Build
# CodePipeline/CodeDeploy
variable "app_name" {
  type = string
}

variable "deployment_group_name" {
  type = string
}

variable "ec2_tag_filter" {
  type = object({
    key   = string
    type  = string
    value = string
  })
}

variable "pipeline_name" {
  type = string
}

variable "github_connection_name" {
  type = string
}

variable "github_repo_id" {
  type = string
}

variable "github_repo_branch" {
  type = string
  default = "main"
}