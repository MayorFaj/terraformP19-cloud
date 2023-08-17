#--- security/variables.tf ----
variable "vpc_id" {
  type        = string
  description = "The main vpc"
}

variable "tags" {
  description = "A mapping of tags to assign to all resources"
  type        = map(string)
  default     = {}
}

variable "myip" {
  type = list(any)
  sensitive = true
}