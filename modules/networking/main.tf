#--- networking/main.tf ---




#get list of availability zone
data "aws_availability_zones" "available" {
  state = "available"
}

#random integer for main vpc
resource "random_integer" "random" {
  min = 1
  max = 100
}

#create random resource for AZ
resource "random_shuffle" "az_list" {
  input        = data.aws_availability_zones.available.names
  result_count = 20
}

#create main vpc
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = var.enable_dns_hostnames
  enable_dns_support   = var.enable_dns_support

  tags = merge(
    var.tags,
    {
      Name = "pbl-main-vpc-${random_integer.random.id}"
    },
  )

}

#create public subnets
resource "aws_subnet" "pbl-public" {
  count                   = var.preferred_number_of_pub_subnets == null ? length(data.aws_availability_zones.available.names) : var.preferred_number_of_pub_subnets
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_cidr[count.index]
  map_public_ip_on_launch = true
  availability_zone       = random_shuffle.az_list.result[count.index]

  tags = merge(
    var.tags,
    {
      Name = "pbl-public-${count.index + 1}"
    },
  )
}


#create private subnets ---
resource "aws_subnet" "pbl-private" {
  count                   = var.preferred_number_of_priv_subnets == null ? legth(data.aws_availability_zones.available.names) : var.preferred_number_of_priv_subnets
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.private_cidr[count.index]
  map_public_ip_on_launch = false
  availability_zone       = random_shuffle.az_list.result[count.index]

  tags = merge(
    var.tags,
    {
      Name = "pbl-private-${count.index + 1}"
    },
  )
}


