resource "aws_connect_instance" "example" {
  identity_management_type = "CONNECT_MANAGED"
  inbound_calls_enabled    = true
  instance_alias           = var.connect_instance_name
  outbound_calls_enabled   = true
}

resource "aws_connect_contact_flow" "example" {
  instance_id = aws_connect_instance.example.id
  name        = "ExampleContactFlow"
  description = "Example contact flow"
  content     = <<EOF
{
  "Version": "2019-10-31",
  "StartAction": {
    "ActionType": "ConnectBot",
    "Parameters": {
      "BotAliasArn": "${aws_lex_bot.example.arn}"
    }
  }
  // Add additional actions and steps here
}
EOF
}

output "connect_instance_id" {
  value = aws_connect_instance.example.id
}

output "contact_flow_id" {
  value = aws_connect_contact_flow.example.id
}
