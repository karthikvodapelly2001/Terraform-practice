resource "aws_lambda_function" "prodLambda" {

  # Create Lambda Function

  function_name = "my-terraform-lambda"
  runtime       = "python3.13"
  role = "arn:aws:iam::675717365613:role/aws-tf-lambda"
  handler       = "lambda_fun.lambda_handler"

  filename         = "lambda_fun.zip" # Zip file containing the function
  source_code_hash = filebase64sha256("lambda_fun.zip")

  timeout     = 900
  memory_size = 128
}

# Output Lambda Function ARN
output "lambda" {
  value = aws_lambda_function.prodLambda.function_name
}
