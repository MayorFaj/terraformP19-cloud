#-- compute/variables.tf

variable "keypair" {}

variable "subnets-compute" {}

variable "sg-compute" {}

variable "ami-jfrog" {}

variable "ami-jenkins" {}

variable "ami-sonar" {}

variable "tags" {
  description = "A mapping of tags to assign to all resources"
  type        = map(string)
  default     = {}
}