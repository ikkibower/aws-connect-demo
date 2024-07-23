resource "aws_lambda_function" "book_hotel_lambda" {
  filename         = "../lambdas/book-hotel/lambda.zip"
  function_name    = "BookHotelLambda"
  role             = aws_iam_role.lambda_exec.arn
  handler          = "lambda_function.lambda_handler"
  runtime          = "python3.11"
  source_code_hash = filebase64sha256("../lambdas/book-hotel/lambda.zip")
  environment {
    variables = {
      test = "test"
    }
  }
}

resource "aws_lambda_function" "flow_invocation_lambda" {
  filename         = "../lambdas/flow-invocation/lambda.zip"
  function_name    = "FlowInvocationLambda"
  role             = aws_iam_role.lambda_exec.arn
  handler          = "lambda_function.lambda_handler"
  runtime          = "python3.11"
  source_code_hash = filebase64sha256("../lambdas/flow-invocation/lambda.zip")
  environment {
    variables = {
      test = "test"
    }
  }
}

resource "aws_iam_role" "lambda_exec" {
  name = "lambda_exec_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_exec_attach" {
  role       = aws_iam_role.lambda_exec.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

output "lambda_function_arn" {
  value = aws_lambda_function.book_hotel_lambda.arn
}
