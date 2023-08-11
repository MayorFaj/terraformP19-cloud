#--- root/terrafom.tfvars ---
vpc_cidr = "10.0.0.0/16"

aws_region = "eu-central-1"

enable_dns_hostnames = true

enable_dns_support = true

preferred_number_of_pub_subnets = 2

preferred_number_of_priv_subnets = 6

tags = {
  Environment     = "production"
  Department      = "Operations"
  Owner-Email     = "mayorfaj.io@gmail.com"
  Managed-By      = "Terraform"
  Billing-Account = "953523290929"
}

ami = "ami-06040de751fc1d99d"

account_no = "953523290929"

master-password = "Ashabi_123"

master-username = "mayor"

public_key_path = "/Users/mozart/.ssh/terraform-pbl.pub"


