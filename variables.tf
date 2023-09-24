#--- root/variables.tf ---

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

variable "tags" {
  description = "A mapping of tags to assign to all resources"
  type        = map(string)
  default     = {}
}


variable "account_no" {
  type = string
}

variable "master-password" {
  description = "password for database"
  type        = string
  sensitive   = true
}

variable "master-username" {
  type = string
}

variable "ami-bastion" {
  type = string
  description = "AMI ID for bastion"
}

variable "ami-nginx" {
  type = string
  description = "AMI ID for nginx reverse-proxy"
}

variable "ami-wordpress" {
  type = string
  description = "AMI ID for wordpress webservers"
}

variable "ami-tooling" {
  type = string
  description = "AMI ID for tooling webservers"
}

variable "ami-jenkins" {
  type = string
  description = "AMI ID for compute"
}

variable "ami-sonar" {
  type = string
  description = "AMI ID for compute"
}

variable "ami-jfrog" {
  type = string
  description = "AMI ID for compute"
}

variable "key_pair" {
  type = string
}

variable "myip" {
  type = list(any)
}