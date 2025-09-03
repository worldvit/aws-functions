# resource "aws_instance" "web_server" {
#   ami = var.ec2_ami_id

#   instance_type = element(var.instance_types, 0)
#   subnet_id     = aws_subnet.main["subnet-a-1"].id

#   tags = {
#     Name = "WebServer-${element(var.instance_types, 0)}"
#   }
# }

# resource "aws_instance" "web_server" {
#   ami           = var.ec2_ami_id
#   instance_type = element(var.instance_types, 0)
#   subnet_id     = aws_subnet.main["subnet-a-1"].id

#   # 1. 생성한 보안 그룹을 EC2 인스턴스에 적용합니다.
#   vpc_security_group_ids = [aws_security_group.web_sg.id]

#   # 2. ## join() 함수 사용 예시 ##
#   # EC2 인스턴스가 시작될 때 실행할 스크립트를 정의합니다.
#   user_data = join("\n", [
#     "#!/bin/bash",
#     "sudo apt-get update -y",
#     "sudo apt-get install -y nginx",
#     "sudo systemctl start nginx",
#     "sudo systemctl enable nginx",
#     "echo '<h1>Hello, World from Terraform!</h1>' | sudo tee /var/www/html/index.html"
#   ])

#   tags = {
#     Name = "WebServer - ${element(var.instance_types, 0)}"
#   }
# }

# resource "aws_instance" "web_server" {
#   ami                    = var.ec2_ami_id
#   instance_type          = element(var.instance_types, 0)
#   subnet_id              = aws_subnet.main["subnet-a-1"].id
#   vpc_security_group_ids = [aws_security_group.web_sg.id]

#   # Use the file() function to read the script
#   user_data = file("web-init.sh")

#   tags = {
#     Name = "WebServer - ${element(var.instance_types, 0)}"
#   }
# }

resource "aws_instance" "web_server" {
  ami           = var.ec2_ami_id
  instance_type = element(var.instance_types, 0)
  subnet_id     = aws_subnet.main["subnet-a-1"].id

  # ## concat() function example ##
  # Combines the web_sg and monitoring_sg into a single list of security group IDs.
  vpc_security_group_ids = concat(
    [aws_security_group.web_sg.id],
    [aws_security_group.monitoring_sg.id]
  )

  user_data = file("web-init.sh")

  tags = {
    Name = "WebServer - ${element(var.instance_types, 0)}"
  }
}