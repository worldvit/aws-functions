# batch.tf

resource "aws_instance" "batch_server" {
  ami           = var.ec2_ami_id
  instance_type = "t3.micro" # Example instance type

  # Place it in a private subnet for processing tasks
  subnet_id              = aws_subnet.main["subnet-b-2"].id
  vpc_security_group_ids = [aws_security_group.db_sg.id] # Reuse DB SG for internal access example

  # ## merge() function example ##
  # Combines the common tags from variables with a specific Name tag for this instance.
  tags = merge(
    var.common_tags,
    {
      "Name" = "Batch-Processing-Server"
    }
  )
}