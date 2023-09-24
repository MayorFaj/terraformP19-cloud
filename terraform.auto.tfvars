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

ami-bastion = "ami-09084caafe3942e5d"

ami-nginx = "ami-0afde439fdf5c5176"

ami-wordpress = "ami-09da9609282ec2b63"

ami-tooling = "ami-09da9609282ec2b63"

ami-jenkins = "ami-03ea1dd6c7623ad2e"

ami-sonar = "ami-03ea1dd6c7623ad2e"
  
ami-jfrog = "ami-03ea1dd6c7623ad2e"

account_no = "953523290929"

master-password = "Ashabi_123"

master-username = "mayor"

#key_pair = "pal-key"

