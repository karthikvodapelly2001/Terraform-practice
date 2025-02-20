resource "aws_instance" "name" {
  ami           = "ami-085ad6ae776d8f09c"
  key_name      = "nv-personal-KP"
  instance_type = "t2.micro"
  availability_zone = "us-east-1a"

  tags = {
    Name = "My-Server"  # This sets the instance name
    Environment = "Dev"  # You can add more tags if needed
  }
#   lifecycle {
#     create_before_destroy = true
#   }

  lifecycle {
    prevent_destroy = false
  }
#   lifecycle {
#     ignore_changes = [ tags ]
#   }
}

