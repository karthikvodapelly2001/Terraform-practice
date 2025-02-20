resource "aws_db_instance" "prodRDS" {
  allocated_storage    = 20
  identifier           = "prod-rds"
  db_name              = "prodrds"
  engine               = "mysql"
  engine_version       = "8.0.40"
  instance_class       = "db.t3.micro"
  username             = "admin"
  password             = "Karthik123"
  parameter_group_name = "default.mysql8.0"
  skip_final_snapshot  = true
  availability_zone    = "us-east-1b"
  db_subnet_group_name = "tf-subnetgroup"


  tags = {
    Name = "tfproddb"
  }
}


output "RDS" {
  value = aws_db_instance.prodRDS.engine
}
