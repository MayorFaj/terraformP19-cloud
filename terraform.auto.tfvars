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

ami-bastion = "ami-06f70a42ac193e4c2"

ami-nginx = "ami-09801e5b89a48363c"

ami-wordpress = "ami-0d3b1fe306c70acbe"

ami-tooling = "ami-0d3b1fe306c70acbe"

ami-jenkins = "ami-0d3b1fe306c70acbe"

ami-sonar = "ami-0d3b1fe306c70acbe"
  
ami-jfrog = "ami-0d3b1fe306c70acbe"

account_no = "953523290929"

master-password = "Ashabi_123"

master-username = "mayor"

key_pair = "pal-key"

