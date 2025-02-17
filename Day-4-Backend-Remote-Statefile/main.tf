resource "aws_instance" "name" {
  ami           = "ami-085ad6ae776d8f09c"
  key_name      = "nv-personal-KP"
  instance_type = "t2.micro"

  tags = {
    Name = "My-Server-prod"  # This sets the instance name
    Environment = "Dev"  # You can add more tags if needed
  }
}

resource "aws_s3_bucket" "name" {

  bucket = "thisistfbuckettt"
  
  
}