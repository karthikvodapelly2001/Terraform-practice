module "prod-rds" {
  providers = {
    aws = aws.us
  }
  source               = "terraform-aws-modules/rds/aws"
  identifier           = "prod-rds"
  engine               = "mysql"
  engine_version       = "8.0.40"
  instance_class       = "db.t3.micro"
  allocated_storage    = 5
  skip_final_snapshot  = true
  db_subnet_group_name = "default-vpc-071b68e75ce48911c"
  db_name              = "prod-rdss"
  username             = "admin"
  password             = "karthik@123"

  major_engine_version = "8.0"
  family               = "mysql8.0"

  backup_retention_period = 1             # 🔥 Enable backups (Must be >=1)
  backup_window           = "02:00-03:00" # Optional: Set backup time

  vpc_security_group_ids = ["sg-072b7d394441bba0f"]

  tags = {
    Owner       = "user"
    Environment = "dev"
  }
}

module "prod-rds-replica" {
  providers = {
    aws = aws.ap
  }

  source              = "terraform-aws-modules/rds/aws"
  identifier          = "prodrdsreplica"
  engine              = "mysql"
  engine_version      = "8.0.40"
  instance_class      = "db.t3.micro"
  skip_final_snapshot = true


  replicate_source_db = module.prod-rds.arn

  major_engine_version = "8.0"
  family               = "mysql8.0"



  tags = {
    Owner       = "user"
    Environment = "dev"
    Type        = "Read-Replica"
  }
}
