# Elastic IP für NAT Gateway
resource "aws_eip" "nat" {
  domain = "vpc"
  tags = {
    Name = "kamyar-nat-eip"
  }
}

# NAT Gateway
resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public_subnet_1.id
  tags = {
    Name = "kamyar-nat-gateway"
  }
}