locals {
  instance_alias = "ZWxsaW90dHN0ZXN0aW5zdGFuZQo"
}

module "lambdas" {
  source = "../lambdas"
}

resource "aws_connect_instance" "test_connect_instance" {
  identity_management_type = "CONNECT_MANAGED"
  inbound_calls_enabled    = true
  instance_alias           = local.instance_alias
  outbound_calls_enabled   = true
}



resource "aws_connect_phone_number" "test_tfn" {
  target_arn   = aws_connect_instance.test_connect_instance.arn
  country_code = "US"
  type         = "DID"
  prefix       = "+1657"
}

resource "aws_connect_lambda_function_association" "flow_invocation_lambda_connect_association" {
  function_arn = module.lambdas.flow_invocation_lambda_invoke_arn
  instance_id  = aws_connect_instance.test_connect_instance.id
}

output "connect_instance_id" {
  value = aws_connect_instance.test_connect_instance.id
}

output "connect_instance_arn" {
  value = aws_connect_instance.test_connect_instance.arn
}
