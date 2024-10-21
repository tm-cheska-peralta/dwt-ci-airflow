variable "public_sg_name" {
  type = string
}

variable "private_sg_name" {
  type = string
}

variable "database_sg_name" {
  type = string
}

variable "public_sg_tags" {
  type    = map(string)
  default = {}
}

variable "private_sg_tags" {
  type    = map(string)
  default = {}
}

variable "database_sg_tags" {
  type    = map(string)
  default = {}
}

variable "vpc_id" {
  type = any
}

variable "public_cidr_blocks" {
  type    = list(string)
  default = ["0.0.0.0/0"]
}

variable "private_cidr_blocks" {
  description = "Place here the VPC CIDR block."
  type        = list(string)
}

variable "database_cidr_blocks" {
  type    = list(string)
  default = ["0.0.0.0/0"]
}