# db_security_group.tf

resource "aws_security_group" "db_sg" {
  name        = "database-sg"
  description = "Allow MariaDB traffic from the web server"
  vpc_id      = aws_vpc.main.id

  # Ingress (인바운드) 규칙
  ingress {
    description     = "MariaDB/MySQL from web-sg"
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    # 소스를 IP가 아닌, 웹 서버의 보안 그룹 ID로 지정합니다.
    security_groups = [aws_security_group.web_sg.id]
  }

  # Egress (아웃바운드) 규칙: 외부로 나가는 모든 트래픽 허용
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "db-sg"
  }
}