#security group rule for external alb, to allow acess from any where for HTTP and HTTPS traffic
resource "aws_security_group_rule" "inbound-ext-alb-https" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.pbl["ext_alb_sg"].id
}

resource "aws_security_group_rule" "inbound-ext-alb-http" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.pbl["ext_alb_sg"].id
}

#--------------------
#security group for bastion, to allow acess from work station
resource "aws_security_group_rule" "inbound-bastion-ssh" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = var.myip
  security_group_id = aws_security_group.pbl["bastion_sg"].id
}

#----------------
#secirity group rule for nginx reverse proxy, to allow access from external load balancer and bastion instance only
resource "aws_security_group_rule" "inbound-nginx-https" {
  type                     = "ingress"
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.pbl["ext_alb_sg"].id
  security_group_id        = aws_security_group.pbl["nginx_sg"].id
}

resource "aws_security_group_rule" "inbound-nginx-ssh" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.pbl["bastion_sg"].id
  security_group_id        = aws_security_group.pbl["nginx_sg"].id
}

#---------------------
#security group rule for internal load balancer, to allow acces from nginx proxy servers only
resource "aws_security_group_rule" "inbound-ialb-https" {
  type                     = "ingress"
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.pbl["nginx_sg"].id
  security_group_id        = aws_security_group.pbl["int_alb_sg"].id
}


#--------------------------
#security group rule for webservers, to allow acces from internal load balancer and bastion instance
resource "aws_security_group_rule" "inbound-webserver-https" {
  type                     = "ingress"
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.pbl["int_alb_sg"].id
  security_group_id        = aws_security_group.pbl["webserver_sg"].id
}

resource "aws_security_group_rule" "inbound-webserver-ssh" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.pbl["bastion_sg"].id
  security_group_id        = aws_security_group.pbl["webserver_sg"].id
}


#----------------------
#security group rule for datalayer to allow traffic from websever on nfs and mysql port and traffic from bastion host on mysql port
resource "aws_security_group_rule" "inbound-webserver-nfs" {
  type                     = "ingress"
  from_port                = 2049
  to_port                  = 2049
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.pbl["webserver_sg"].id
  security_group_id        = aws_security_group.pbl["datalayer_sg"].id
}

resource "aws_security_group_rule" "inbound-webserver-mysql" {
  type                     = "ingress"
  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.pbl["webserver_sg"].id
  security_group_id        = aws_security_group.pbl["datalayer_sg"].id
}

resource "aws_security_group_rule" "inbound-bastion-mysql" {
  type                     = "ingress"
  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.pbl["bastion_sg"].id
  security_group_id        = aws_security_group.pbl["datalayer_sg"].id
}


#------------------------------
#security group rule for compute , to allow traffic from anywhere on jenkins port,sonarqube port,jfrog port and bastion instance 
resource "aws_security_group_rule" "inbound-jenkins" {
  type              = "ingress"
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.pbl["compute_sg"].id
}

resource "aws_security_group_rule" "inbound-sonarqube" {
  type              = "ingress"
  from_port         = 9000
  to_port           = 9000
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.pbl["compute_sg"].id
}

resource "aws_security_group_rule" "inbound-artifactory" {
  type              = "ingress"
  from_port         = 8081
  to_port           = 8081
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.pbl["compute_sg"].id
}

resource "aws_security_group_rule" "inbound-bastion-ssh-compute" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  source_security_group_id = aws_security_group.pbl["bastion_sg"].id
  security_group_id = aws_security_group.pbl["compute_sg"].id
}