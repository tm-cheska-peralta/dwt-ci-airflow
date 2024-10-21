variable "bucket_name" {
  type = string
}

variable "acl" {
  type    = string
  default = "private"
}

variable "enable_versioning" {
  type    = bool
  default = true
}

variable "versioning_status" {
  description = "Valid values: Enabled, Suspended, Disabled"
  type        = string
  default     = "Enabled"
}

variable "mfa_delete" {
  description = "Valid values: Enabled, Disabled"
  type        = string
  default     = "Disabled"
}

variable "sse_algorithm" {
  description = "Valid values: AES256, aws:kms"
  type        = string
  default     = "AES256"
}

variable "kms_master_key_id" {
  type    = any
  default = null
}

variable "block_public_acls" {
  type    = bool
  default = true
}

variable "block_public_policy" {
  type    = bool
  default = true
}

variable "ignore_public_acls" {
  type    = bool
  default = true
}

variable "restrict_public_buckets" {
  type    = bool
  default = true
}

variable "attach_policy" {
  type    = bool
  default = false
}

variable "policy" {
  type    = any
  default = null
}

variable "tags" {
  type    = map(string)
  default = {}
}
