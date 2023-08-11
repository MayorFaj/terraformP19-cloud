#--- root/outputs.tf

#external alb

output "s3_bucket_arn" {
  value       = aws_s3_bucket.terraform_state.arn
  description = "The name of the s3 bucket"
}

output "dynamodb_table_name" {
  value       = aws_dynamodb_table.terraform_locks.name
  description = "The name of the DynamoDB table"
}


output "alb_target_group_arn" {
  value       = module.alb.alb_target_group_arn
}

output "alb_dns_name" {
  value       = module.alb.alb_dns_name
}