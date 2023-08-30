#--- alb/variables.tf ----

variable "public_sg" {}

variable "pub_subnet_1" {}

variable "pub_subnet_2" {}

variable "ip_address_type" {}

variable "load_balancer_type" {}

variable "port" {}

variable "protocol" {}

variable "private_sg" {
  type        = string
  description = "Security group for internal load balancer"
}

variable "priv_subnet_3" {}

variable "priv_subnet_4" {}

variable "vpc_id" {}

variable "tags" {
  description = "A mapping of tags to assign to all resources"
  type        = map(string)
  default     = {}
}

