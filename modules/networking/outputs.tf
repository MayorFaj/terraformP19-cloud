#--- networking/outputs.tf ----

output "vpc_id" {
  value       = aws_vpc.main.id
  description = "The main vpc"
}

output "instance_profile" {
  value = aws_iam_instance_profile.ip.id
}

output "private_subnet_1" {
  value       = aws_subnet.pbl-private[0].id
  description = "The first private subnet"
}

output "private_subnet_2" {
  value       = aws_subnet.pbl-private[1].id
  description = "The second private subnet"
}

output "private_subnet_3" {
  value       = aws_subnet.pbl-private[2].id
  description = "The third private subnet"
}

output "private_subnet_4" {
  value       = aws_subnet.pbl-private[3].id
  description = "The fourth private subnet"
}

output "private_subnet_5" {
  value       = aws_subnet.pbl-private[4].id
  description = "The fifth private subnet"
}

output "private_subnet_6" {
  value       = aws_subnet.pbl-private[5].id
  description = "The sixth private subnet"
}

output "public_subnet_1" {
  value       = aws_subnet.pbl-public[0].id
  description = "The first public subnet"
}

output "public_subnet_2" {
  value       = aws_subnet.pbl-public[1].id
  description = "The second public subnet"
}

