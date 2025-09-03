# Create the Public Route Table
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  # Route all internet-bound traffic (0.0.0.0/0) to the Internet Gateway
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = {
    Name = "public-rt"
  }
}

# Create the Private Route Table
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  # Route all internet-bound traffic (0.0.0.0/0) to the NAT Gateway
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.main.id
  }

  tags = {
    Name = "private-rt"
  }
}

# 라우팅 테이블 연결(Association) 생성
resource "aws_route_table_association" "main" {
  # variables.tf에 정의된 모든 서브넷에 대해 반복 실행
  for_each = var.subnets

  # 현재 반복중인 서브넷의 ID를 지정
  subnet_id = aws_subnet.main[each.key].id

  # 조건문을 사용하여 올바른 라우팅 테이블 ID를 선택
  # 만약 서브넷의 'is_public' 플래그가 true이면, public 라우팅 테이블에 연결하고,
  # 그렇지 않으면(false이면), private 라우팅 테이블에 연결합니다.
  route_table_id = each.value.is_public ? aws_route_table.public.id : aws_route_table.private.id
}