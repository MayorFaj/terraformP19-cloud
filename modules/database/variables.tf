#--- database/variables.tf ----

variable "private_subnet_5" {}

variable "private_subnet_6" {}

variable "rds-sg" {}

variable "master-username" {}

variable "master-password" {}

variable "tags" {
  description = "A mapping of tags to assign to all resources"
  type        = map(string)
  default     = {}
}

