#--- networking/route_tables.tf

#create  route table for the private subnets
resource "aws_route_table" "priv-rtb" {
  vpc_id = aws_vpc.main.id

  tags = merge(
    var.tags,
    {
      Name = "pbl_priv-rtb"
    },
  )
}

#create route for the private route table and attach NAT gateway
resource "aws_route" "priv-rtb-route" {
  route_table_id         = aws_route_table.priv-rtb.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_nat_gateway.pbl-ngw.id
}

#associate the private subnets to the private route table
resource "aws_route_table_association" "priv-subnets-assoc" {
  count          = length(aws_subnet.pbl-private[*].id)
  subnet_id      = element(aws_subnet.pbl-private[*].id, count.index)
  route_table_id = aws_route_table.priv-rtb.id
}

#create  route table for the public subnets
resource "aws_route_table" "pub-rtb" {
  vpc_id = aws_vpc.main.id

  tags = merge(
    var.tags,
    {
      Name = "pbl-pub-rtb"
    },
  )
}

#create route for the public route table and attach internet gateway
resource "aws_route" "pub-rtb-route" {
  route_table_id         = aws_route_table.pub-rtb.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.pbl-igw.id
}

#associate the public subnets to the public route table
resource "aws_route_table_association" "pub-subnets-assoc" {
  count          = length(aws_subnet.pbl-public[*].id)
  subnet_id      = aws_subnet.pbl-public.*.id[count.index]
  route_table_id = aws_route_table.pub-rtb.id
}