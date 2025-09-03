/*
resource "aws_subnet" "main" {
  count = length(var.subnet_cidrs)
  vpc_id = aws_vpc.main.id
  cidr_block = var.subnet_cidrs[count.index]
  tags = {
    Name = "main-subnet-${count.index}"
  }
}
*/

# resource "aws_subnet" "main" {
#   for_each = var.subnets

#   vpc_id            = aws_vpc.main.id
#   cidr_block        = each.value.cidr_block
#   availability_zone = each.value.az
#   map_public_ip_on_launch = true
#   tags = {
#     Name = "main-${each.key}"
#   }
# }

resource "aws_subnet" "main" {
  for_each = var.subnets

  vpc_id            = aws_vpc.main.id
  cidr_block        = each.value.cidr_block
  availability_zone = each.value.az

  # Set based on the 'is_public' flag from the variable
  map_public_ip_on_launch = each.value.is_public

  tags = {
    Name = "main-${each.key}"
  }
}