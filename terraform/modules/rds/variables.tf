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
  type    = number
  default = 5432
}

variable "engine" {
  type = string
}

variable "engine_version" {
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

variable "database_subnet_ids" {
  type = list(string)
}

variable "multi_az" {
  type    = bool
  default = false
}

variable "availability_zone" {
  type    = string
  default = null
}

variable "vpc_security_group_ids" {
  type = list(string)
}

variable "deletion_protection" {
  type = bool
}

variable "skip_final_snapshot" {
  type    = bool
  default = false
}

variable "final_snapshot_identifier" {
  description = "Must be provided if skip_final_snapshot is set to false"
  type        = string
  default     = "snapshot"
}

variable "tags" {
  type    = map(string)
  default = {}
}

variable "create_parameter_group" {
  type    = bool
  default = true
}

variable "family" {
  type    = string
  default = null
}

variable "parameters" {
  description = "A list of DB parameter maps to apply"
  type        = list(map(string))
  default     = []
}