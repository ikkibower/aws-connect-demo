output "flow_invocation_lambda_bucket" {
  value = aws_s3_bucket.flow_invocation_lambda_bucket.bucket
}

output "flow_invocation_lambda_layer_zip" {
  value = aws_s3_bucket_object.flow_invocation_lambda_layer_zip.key
}