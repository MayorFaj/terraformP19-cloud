#--- networking/natgateway.tf ---

resource "aws_eip" "pbl-nat-eip" {
  domain     = "vpc"
  depends_on = [aws_internet_gateway.pbl-igw]

  tags = merge(
    var.tags,
    {
      Name = format("%s-EIP", "pbl-nat")
    },
  )
}

resource "aws_nat_gateway" "pbl-ngw" {
  allocation_id = aws_eip.pbl-nat-eip.id
  subnet_id     = element(aws_subnet.pbl-public.*.id, 0)
  depends_on    = [aws_internet_gateway.pbl-igw]

  tags = merge(
    var.tags,
    {
      Name = format("%s-Nat", "pbl")
    },
  )
}
