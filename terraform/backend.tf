terraform {
  backend "s3" {
    bucket = "tf-state-aws-connect-demo"
    key    = "aws-connect-demo.terraform.tfstate"
    region = "us-east-1"
  }
}
