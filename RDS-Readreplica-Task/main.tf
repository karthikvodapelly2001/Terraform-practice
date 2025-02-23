resource "aws_db_instance" "RDS" {
  provider                = aws.us
  instance_class          = var.DB_instance_class
  identifier              = var.DB_instance_identifier
  engine                  = var.engine_options
  engine_version          = var.engine_version
  username                = var.username
  password                = var.password
  allocated_storage       = var.allocated_storage
  vpc_security_group_ids  = var.VPC_sg
  db_subnet_group_name    = var.subnet_group
  availability_zone       = var.AZ
  backup_retention_period = 7 # Must be > 0 for Read Replicas
  skip_final_snapshot     = true
  publicly_accessible     = false
  multi_az                = false
  storage_type            = "gp2"
}

resource "aws_db_instance" "RDS_read_replica" {
  provider            = aws.ap
  identifier          = "rds-read-replica"
  instance_class      = var.DB_instance_class
  replicate_source_db = aws_db_instance.RDS.arn  
  availability_zone   = "ap-south-1a"
  publicly_accessible = false
  skip_final_snapshot = true

  tags = {
    Name = "Read Replica"
  }
}


