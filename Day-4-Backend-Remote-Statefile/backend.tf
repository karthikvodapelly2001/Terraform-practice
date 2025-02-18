terraform {
  backend "s3" {
    bucket         = "buckettdynamodb"
    key            = "terraform.tfstate"
    region         = "us-east-1"  # Make sure this matches DynamoDB region
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}

