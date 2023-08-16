#--- autoscaling/variables.tf ----

variable "ami-bastion" {}

variable "ami-nginx" {}

variable "bastion-sg" {}

variable "instance_profile" {}

variable "max_size" {}

variable "min_size" {}

variable "desired_capacity" {}

variable "public_subnet_1" {}

variable "public_subnet_2" {}

variable "nginx-sg" {}

variable "private_subnet_1" {}

variable "private_subnet_2" {}

variable "nginx-alb-tg" {}

variable "ami-wordpress" {}

variable "ami-tooling" {}

variable "webserver-sg" {}

variable "private_subnet_3" {}

variable "private_subnet_4" {}

variable "wordpress-alb-tg" {}

variable "tooling-alb-tg" {}

variable "tags" {
  description = "A mapping of tags to assign to all resources"
  type        = map(string)
  default     = {}
}



