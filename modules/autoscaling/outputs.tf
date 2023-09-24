#--- autoscaling/outputs.tf ----

output "key_pair" {
  value = aws_key_pair.terraform-pbl19.key_name
}