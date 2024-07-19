resource "aws_lex_bot" "example" {
  name        = var.lex_bot_name
  description = "Example Lex bot"
  # Add intents, slots, and other Lex bot configurations here
}

output "lex_bot_id" {
  value = aws_lex_bot.example.id
}
