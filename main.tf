#--- root/main.tf ---

# resource "aws_s3_bucket" "terraform_state" {
#   bucket        = "mayorfaj-dev-terraform-bucket"
#   force_destroy = true
# }

# # Enable versioning so we can see the full revision history of our state files
# resource "aws_s3_bucket_versioning" "terraform_state_versioning" {
#   bucket = aws_s3_bucket.terraform_state.id
#   versioning_configuration {
#     status = "Enabled"
#   }
# }

# # Enable server-side encryption by default
# resource "aws_s3_bucket_server_side_encryption_configuration" "encrypt" {
#   bucket = aws_s3_bucket.terraform_state.id

#   rule {
#     apply_server_side_encryption_by_default {
#       sse_algorithm = "AES256"
#     }
#   }
# }

# resource "aws_dynamodb_table" "terraform_locks" {
#   name         = "terraform-locks"
#   billing_mode = "PAY_PER_REQUEST"
#   hash_key     = "LockID"
#   attribute {
#     name = "LockID"
#     type = "S"
#   }
# }

module "networking" {
  source                           = "./modules/networking"
  aws_region                       = var.aws_region
  vpc_cidr                         = var.vpc_cidr
  private_cidr                     = [for i in range(2, 255, 2) : cidrsubnet(var.vpc_cidr, 8, i)]
  public_cidr                      = [for i in range(1, 255, 2) : cidrsubnet(var.vpc_cidr, 8, i)]
  enable_dns_hostnames             = true
  enable_dns_support               = true
  preferred_number_of_pub_subnets  = var.preferred_number_of_pub_subnets
  preferred_number_of_priv_subnets = var.preferred_number_of_priv_subnets
}

module "alb" {
  source             = "./modules/alb"
  vpc_id             = module.networking.vpc_id
  public_sg          = module.security.ext_alb_sg
  private_sg         = module.security.int_alb_sg
  pub_subnet_1       = module.networking.public_subnet_1
  pub_subnet_2       = module.networking.public_subnet_2
  priv_subnet_1      = module.networking.private_subnet_1
  priv_subnet_2      = module.networking.private_subnet_2
  ip_address_type    = "ipv4"
  load_balancer_type = "application"
  port               = 443
  protocol           = "HTTPS"
}

module "security" {
  source = "./modules/security"
  vpc_id = module.networking.vpc_id
}

module "autoscaling" {
  source           = "./modules/autoscaling"
  bastion-sg       = module.security.bastion_sg
  nginx-sg         = module.security.nginx_sg
  webserver-sg     = module.security.webserver_sg
  ami-bastion      = var.ami-bastion
  ami-nginx        = var.ami-nginx
  ami-wordpress    = var.ami-wordpress
  ami-tooling      = var.ami-tooling
  private_subnet_1 = module.networking.private_subnet_1
  private_subnet_2 = module.networking.private_subnet_2
  private_subnet_3 = module.networking.private_subnet_3
  private_subnet_4 = module.networking.private_subnet_4
  max_size         = 3
  min_size         = 1
  desired_capacity = 2
  public_subnet_1  = module.networking.public_subnet_1
  public_subnet_2  = module.networking.public_subnet_2
  nginx-alb-tg     = module.alb.nginx_tg
  wordpress-alb-tg = module.alb.wordpress_tg
  tooling-alb-tg   = module.alb.tooling_tg
  instance_profile = module.networking.instance_profile
  key_pair = var.pub_key
}

module "database" {
  source           = "./modules/database"
  private_subnet_5 = module.networking.private_subnet_5
  private_subnet_6 = module.networking.private_subnet_6
  rds-sg           = module.security.datalayer_sg
  master-username  = var.master-username
  master-password  = var.master-password
}

module "filesystem" {
  source       = "./modules/filesystem"
  efs-subnet-1 = module.networking.private_subnet_3
  efs-subnet-2 = module.networking.private_subnet_4
  efs-sg       = module.security.datalayer_sg
  account_no   = var.account_no
}

module "compute" {
  source = "./modules/compute"
  key_pair = var.pub_key
  subnets-compute = module.networking.public_subnet_1
  sg-compute = module.security.ext_alb_sg
  ami-jenkins = var.ami-jenkins
  ami-sonar = var.ami-sonar
  ami-jfrog = var.ami-jfrog
}