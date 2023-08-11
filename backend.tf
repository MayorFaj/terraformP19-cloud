



# terraform {
#   backend "s3" {
#     bucket         = "mayorfaj-dev-terraform-bucket"
#     key            = "global/s3/terraform.tfstate"
#     region         = "eu-central-1"
#     dynamodb_table = "terraform-locks"
#     encrypt        = true
#   }
# }