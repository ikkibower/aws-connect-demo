output "lex_bot_id_output" {
  value = module.lex_bot.lex_bot_id
}

output "lambda_function_arn_output" {
  value = module.lambda_function.lambda_function_arn
}

output "connect_instance_id_output" {
  value = module.connect.connect_instance_id
}

output "contact_flow_id_output" {
  value = module.connect.contact_flow_id
}
