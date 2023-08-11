#--- networking/variables.tf ----

variable "aws_region" {
  type        = string
  description = "The region to deploy resources"
}

variable "vpc_cidr" {
  type        = string
  description = "The VPC cidr"
}

variable "enable_dns_hostnames" {
  type = bool
}

variable "enable_dns_support" {
  type = bool
}

variable "preferred_number_of_pub_subnets" {
  type = number
}

variable "preferred_number_of_priv_subnets" {
  type = number
}

variable "public_cidr" {
  type = list(any)
}

variable "private_cidr" {
  type = list(any)
}


variable "tags" {
  description = "A mapping of tags to assign to all resources"
  type        = map(string)
  default     = {}
}

