#--- security/outputs.tf ----

output "ext_alb_sg" {
  value = aws_security_group.pbl["ext_alb_sg"].id
}

output "bastion_sg" {
  value = aws_security_group.pbl["bastion_sg"].id
}

output "nginx_sg" {
  value = aws_security_group.pbl["nginx_sg"].id
}

output "int_alb_sg" {
  value = aws_security_group.pbl["int_alb_sg"].id
}

output "webserver_sg" {
  value = aws_security_group.pbl["webserver_sg"].id
}

output "datalayer_sg" {
  value = aws_security_group.pbl["datalayer_sg"].id
}

output "compute_sg" {
  value = aws_security_group.pbl["compute_sg"].id
}