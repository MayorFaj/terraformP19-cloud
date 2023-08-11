#---filesystem/variables.tf

variable "efs-subnet-1" {}

variable "efs-subnet-2" {}

variable "efs-sg" {}

variable "account_no" {}

variable "tags" {
  description = "A mapping of tags to assign to all resources"
  type        = map(string)
  default     = {}
}