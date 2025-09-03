# resource "aws_security_group" "web_sg" {
#   name        = "web-server-sg"
#   description = "Allow HTTP and SSH inbound traffic"
#   vpc_id      = aws_vpc.main.id

#   # Ingress (인바운드) 규칙: 외부 -> 서버
#   ingress {
#     description = "HTTP from anywhere"
#     from_port   = 80
#     to_port     = 80
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   # Add this new block for SSH access
#   ingress {
#     description = "SSH from My IP"
#     from_port   = 22
#     to_port     = 22
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"] # IMPORTANT: Replace with your IP
#   }

#   # Egress (아웃바운드) 규칙: 서버 -> 외부
#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   tags = {
#     Name = "web-sg"
#   }
# }

# 기존 보안 그룹 리소스에서 ingress 블록들을 제거합니다.
resource "aws_security_group" "web_sg" {
  name        = "web-server-sg"
  description = "Allow dynamic inbound traffic"
  vpc_id      = aws_vpc.main.id

  # Egress (아웃바운드) 규칙은 그대로 둡니다.
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "web-sg"
  }
}

# ## split() 함수 사용 예시 ##
# 별도의 리소스로 보안 그룹 규칙을 정의합니다.
resource "aws_security_group_rule" "inbound_traffic" {
  # for_each를 사용하여 '80,443,22' 문자열을 리스트로 분리한 후, 각 포트에 대해 규칙을 생성합니다.
  for_each = toset(split(",", var.allowed_ports_string))

  type              = "ingress"
  security_group_id = aws_security_group.web_sg.id
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"] # 설명을 위해 모든 IP를 허용 (실제 환경에서는 IP 제한 필요)

  # each.key가 현재 반복중인 포트 번호('80', '443', '22')를 가리킵니다.
  from_port = tonumber(each.key)
  to_port   = tonumber(each.key)
}