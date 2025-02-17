provider "aws" {
  region = "us-east-1"
}



resource "aws_dynamodb_table" "terraform-locks" {
  
  name         = "terraform-locks"
#   billing_mode = "PAY_PER_REQUEST"
read_capacity = 3
write_capacity = 3

  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}
