resource "aws_db_instance" "prodRDS" {
  allocated_storage    = 5
  identifier           = "prod-rds"
  db_name              = "prodrds"
  engine               = "mysql"
  engine_version       = "8.0.40"
  instance_class       = "db.t3.micro"
  username             = "admin"
  password             = "Karthik123" # 🔴 Consider using AWS Secrets Manager instead of hardcoding passwords!
  parameter_group_name = "default.mysql8.0"
  skip_final_snapshot  = true
  availability_zone    = "us-east-1b"
  db_subnet_group_name = "tf-subnetgroup"
  vpc_security_group_ids = [ "sg-072b7d394441bba0f" ]

  tags = {
    Name = "tfproddb"
  }
}

resource "aws_iam_instance_profile" "existing_profile" {
  name = "existing-iam-role"
  role = "ec2cw"
}


resource "aws_instance" "my-Server" {
  ami                  = "ami-05b10e08d247fb927"
  key_name             = "nv-personal-KP"
  instance_type        = "t2.micro"
  iam_instance_profile = aws_iam_instance_profile.existing_profile.name
  


  tags = {
    Name        = "My-Server"
    Environment = "Dev"
  }
}



resource "null_resource" "setup_mysql" {
  

  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = file("C:/Users/karth/Downloads/nv-personal-KP.pem")
    host        = aws_instance.my-Server.public_ip
  }

  provisioner "remote-exec" {
    inline = [

      "sudo yum install mysql -y",


      "if mysql -h prod-rds.cdce422cqyvd.us-east-1.rds.amazonaws.com  -u admin -pKarthik123 -e 'SELECT 1;' > /home/ec2-user/rds_connection.txt 2>&1; then",
      "    echo 'RDS Connection Successful' > /home/ec2-user/rds_connection_success.txt",
      "else",
      "    echo 'RDS Connection Failed' > /home/ec2-user/rds_connection_failed.txt",
      "fi",


      "aws s3 cp /home/ec2-user/rds_connection_success.txt s3://thisistfbuckettt/",
      "aws s3 cp /home/ec2-user/rds_connection_failed.txt s3://thisistfbuckettt/"
    ]
  }
    triggers = {
    instance = aws_instance.my-Server.id
  }
}

