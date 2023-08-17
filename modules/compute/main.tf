#---compute/main.tf ---

# create instance for jenkins
resource "aws_instance" "Jenkins" {
  ami                         = var.ami-jenkins
  instance_type               = "t2.micro"
  subnet_id                   = var.subnets-compute
  vpc_security_group_ids      = [var.sg-compute]
  associate_public_ip_address = true
  key_name                    = var.key_pair

 tags = merge(
    var.tags,
    {
      Name = "pbl-Jenkins"
    },
  )
}


#create instance for sonbarqube
resource "aws_instance" "sonbarqube" {
  ami                         = var.ami-sonar
  instance_type               = "t2.medium"
  subnet_id                   = var.subnets-compute
  vpc_security_group_ids      = [var.sg-compute]
  associate_public_ip_address = true
  key_name                    = var.key_pair


   tags = merge(
    var.tags,
    {
      Name = "pbl-sonbarqube"
    },
  )
}

# create instance for artifactory
resource "aws_instance" "artifactory" {
  ami                         = var.ami-jfrog
  instance_type               = "t2.medium"
  subnet_id                   = var.subnets-compute
  vpc_security_group_ids      = [var.sg-compute]
  associate_public_ip_address = true
  key_name                    = var.key_pair


  tags = merge(
    var.tags,
    {
      Name = "pbl-artifactory"
    },
  )
}
