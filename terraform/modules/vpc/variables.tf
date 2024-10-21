variable "vpc_name" {
  type = string
}

variable "vpc_cidr" {
  type = string
}

variable "vpc_azs" {
  type = list(string)
}

variable "database_subnets" {
  type = list(string)
}

variable "private_subnets" {
  type = list(string)
}

variable "public_subnets" {
  type = list(string)
}

variable "enable_flow_log" {
  type    = bool
  default = false
}

variable "flow_log_destination_type" {
  type    = string
  default = "s3"
}

variable "flow_log_destination_arn" {
  type    = string
  default = ""
}

variable "enable_nat_gateway" {
  type    = bool
  default = true
}

variable "tags" {
  type    = any
  default = {}
}
