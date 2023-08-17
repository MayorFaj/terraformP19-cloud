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

ami-bastion = "ami-09f0441eae8f5ccaf"

ami-nginx = "ami-00da6a61d5bd8544f"

ami-wordpress = "ami-04a51af9d6807f620"

ami-tooling = "ami-04a51af9d6807f620"

ami-jenkins = "ami-03e8b3c02c31ec010"

ami-sonar = "ami-03e8b3c02c31ec010"
  
ami-jfrog = "ami-03e8b3c02c31ec010"

account_no = "953523290929"

master-password = "Ashabi_123"

master-username = "mayor"
