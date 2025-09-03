# Allocate an Elastic IP for the NAT Gateway
resource "aws_eip" "nat" {
  domain = "vpc"
}

# Create the NAT Gateway and place it in the first public subnet
resource "aws_nat_gateway" "main" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.main["subnet-a-1"].id # Must be in a public subnet

  tags = {
    Name = "main-nat-gw"
  }

  # Ensure the Internet Gateway is created before the NAT Gateway
  depends_on = [aws_internet_gateway.main]
}