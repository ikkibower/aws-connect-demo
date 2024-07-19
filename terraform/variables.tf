variable "region" {
  description = "The AWS region to deploy resources"
  default     = "us-east-1"
}

variable "lex_bot_name" {
  description = "The name of the Lex bot"
  default     = "MyLexBot"
}

variable "lambda_function_name" {
  description = "The name of the Lambda function"
  default     = "MyLambdaFunction"
}

variable "connect_instance_name" {
  description = "The name of the Connect instance"
  default     = "MyConnectInstance"
}
