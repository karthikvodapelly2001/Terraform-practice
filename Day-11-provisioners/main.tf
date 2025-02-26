resource "aws_key_pair" "cust-KP" {
  key_name   = "cust-nv-tf"
  public_key = file("C:/Users/karth/.ssh/id_ed25519.pub")
}


resource "aws_instance" "name" {
  ami           = "ami-085ad6ae776d8f09c"
  key_name      = aws_key_pair.cust-KP.key_name
  instance_type = "t2.micro"

  tags = {
    Name        = "My-Server" # This sets the instance name
    Environment = "Dev"       # You can add more tags if needed
  }
  depends_on = [aws_key_pair.cust-KP]

  #local-execution
  provisioner "local-exec" {
    command = "touch file500"
  }

  #remote-execution

  provisioner "remote-exec" {
    inline = [
      "touch file3103",
      "echo hello from aws >> file3103"
    ]
  }
  #file-execution
  provisioner "file" {
    source      = "file10"
    destination = "/home/ec2-user/file10"
  }

  connection { # this connection block is to outhenticate our credintials from local to remote this is for remote-execution provision
    type        = "ssh"
    user        = "ec2-user"                             # Use "ubuntu" if the instance is Ubuntu
    private_key = file("C:/Users/karth/.ssh/id_ed25519") # Private key path
    host        = self.public_ip
  }

}



