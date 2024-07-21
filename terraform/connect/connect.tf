locals {
  instance_alias = "ZWxsaW90dHN0ZXN0aW5zdGFuZQo"
}

module "lex_bot" {
  source = "../lex-bot"
}

resource "aws_connect_instance" "test_connect_instance" {
  identity_management_type = "CONNECT_MANAGED"
  inbound_calls_enabled    = true
  instance_alias           = local.instance_alias
  outbound_calls_enabled   = true
}



resource "aws_connect_contact_flow" "example_contact_flow" {
  instance_id = aws_connect_instance.test_connect_instance.id
  name        = "ExampleContactFlow"
  description = "Example contact flow"
  content     = <<EOF
{
  "Version": "2019-10-31",
  "StartAction": {
    "ActionType": "ConnectBot",
    "Parameters": {
      "BotAliasArn": "${module.lex_bot.lex_bot_arn}"
    }
  }
}
EOF
}

resource "aws_connect_phone_number" "test_tfn" {
  target_arn   = aws_connect_instance.test_connect_instance.arn
  country_code = "US"
  type         = "DID"
  prefix       = "+18005"
}

output "connect_instance_id" {
  value = aws_connect_instance.test_connect_instance.id
}

output "contact_flow_id" {
  value = aws_connect_contact_flow.example_contact_flow.id
}

