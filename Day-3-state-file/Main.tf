resource "aws_instance" "name" {
  ami = "ami-085ad6ae776d8f09c"
  key_name = "nv-personal-KP"
  instance_type = "t2.micro"


}