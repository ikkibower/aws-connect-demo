provider "aws" {
  region = var.region
}

module "lex_bot" {
  source = "./lex-bot"
}

module "lambda_functions" {
  source = "./lambdas"
}

module "connect" {
  source = "./connect"
}

module "dynamodb" {
  source = "./dynamodb"
}

module "s3" {
  source = "./s3"
}