resource "aws_s3_bucket" "flow_invocation_lambda_bucket" {
  bucket = "flow-invocation-lambda-deployment-bucket"
}

resource "aws_s3_bucket_object" "flow_invocation_lambda_layer_zip" {
  bucket = aws_s3_bucket.flow_invocation_lambda_bucket.bucket
  key    = "lambda_layer.zip"
  source = "../lambdas/flow-invocation/lambda_layer.zip"
}