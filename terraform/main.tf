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