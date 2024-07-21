provider "aws" {
  region = var.region
}

module "lex_bot" {
  source = "./lex-bot"
}

module "lambda_function" {
  source = "./lambda"
}

module "connect" {
  source = "./connect"
}