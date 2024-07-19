resource "aws_lex_bot" "example" {
  name        = var.lex_bot_name
  description = "Example Lex bot"
  abort_statement {
    message {
      content      = "Sorry, I am not able to assist at this time"
      content_type = "PlainText"
    }
  }
  child_directed = false
  clarification_prompt {
    max_attempts = 2

    message {
      content      = "I didn't understand you, what would you like to do?"
      content_type = "PlainText"
    }
  }
  create_version              = false
  idle_session_ttl_in_seconds = 600

  intent {
    intent_name    = "BookHotel"
    intent_version = "1"
  }

  locale           = "en-US"
  process_behavior = "BUILD"
  voice_id         = "Salli"
}

output "lex_bot_id" {
  value = aws_lex_bot.example.id
}
