resource "aws_lambda_function" "this" {
  s3_bucket = var.s3_bucket
  s3_key    = var.s3_key

  function_name = "Example"
  role          = aws_iam_role.lambda_execution_role.arn

  handler = "dev.pbx.HelloLambda::handleRequest"

  runtime = "java17"

  source_code_hash = (filebase64sha256("target/terraform-child-module-with-env-tfvars-example-1.0-SNAPSHOT.jar"))

  environment {
    variables = var.env_vars
  }
}

resource "aws_cloudwatch_log_group" "this" {
  name = "/aws/lambda/${aws_lambda_function.this.function_name}"

  retention_in_days = 30
}

resource "aws_iam_role" "lambda_execution_role" {
  name = "lambda-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Sid    = ""
      Principal = {
        Service = "lambda.amazonaws.com"
      }
    }]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_basic_execution_policy" {
  role       = aws_iam_role.lambda_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}