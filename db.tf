# resource "aws_instance" "database_server" {
#   ami           = var.ec2_ami_id
#   instance_type = lookup(var.db_instance_type_map, var.environment, "t3.micro")
#   subnet_id     = aws_subnet.main["subnet-a-2"].id # Private Subnet에 배치

#   # 적용할 보안 그룹을 db_sg로 변경합니다.
#   vpc_security_group_ids = [aws_security_group.db_sg.id]

#   # MariaDB를 설치하는 user_data 스크립트 추가
#   user_data = join("\n", [
#     "#!/bin/bash",
#     "sudo apt-get update -y",
#     "sudo apt-get install -y mariadb-server",
#     "sudo systemctl start mariadb",
#     "sudo systemctl enable mariadb"
#   ])

#   tags = {
#     Name        = "Database Server (${var.environment})"
#     Environment = var.environment
#   }
# }

resource "aws_instance" "database_server" {
  ami                    = var.ec2_ami_id
  instance_type          = lookup(var.db_instance_type_map, var.environment, "t3.micro")
  subnet_id              = aws_subnet.main["subnet-a-2"].id
  vpc_security_group_ids = [aws_security_group.db_sg.id]

  # Use the file() function to read the script
  user_data = file("db-init.sh")

  tags = {
    Name        = "Database Server (${var.environment})"
    Environment = var.environment
  }
}