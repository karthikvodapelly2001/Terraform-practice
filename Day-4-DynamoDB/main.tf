provider "aws" {
  region = "us-east-1"
}



resource "aws_dynamodb_table" "terraform-locks" {
  
  name         = "terraform-locks"
#   billing_mode = "PAY_PER_REQUEST"
read_capacity = 20
write_capacity = 20

  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}
