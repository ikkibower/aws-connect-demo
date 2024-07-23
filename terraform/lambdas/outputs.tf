output "book_hotel_lambda_invoke_arn" {
  value = aws_lambda_function.book_hotel_lambda.arn
}

output "flow_invocation_lambda_invoke_arn" {
  value = aws_lambda_function.flow_invocation_lambda.arn
}
