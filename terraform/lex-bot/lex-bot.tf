module "lambda" {
  source = "../lambda"
}

resource "aws_lexv2models_bot" "book_hotel_bot" {
  name        = var.lex_bot_name
  description = "Lex Bot for booking hotel"
  role_arn    = aws_iam_role.lex_bot_role.arn
  data_privacy {
    child_directed = false
  }
  idle_session_ttl_in_seconds = 600
}

resource "aws_lexv2models_bot_locale" "book_hotel_bot_locale" {
  bot_id                           = aws_lexv2models_bot.book_hotel_bot.id
  bot_version                      = "DRAFT"
  locale_id                        = "en_US"
  n_lu_intent_confidence_threshold = 0.70
  voice_settings {
    voice_id = "Kendra"
    engine   = "standard"
  }
}

resource "aws_lexv2models_bot_version" "book_hotel_bot_version" {
  bot_id = aws_lexv2models.bot.book_hotel_bot.id
  locale_specification = {
    "en_US" = {
      source_bot_version = "DRAFT"
    }
  }
}

resource "aws_lexv2models_intent" "book_hotel_bot_intent" {
  bot_id      = aws_lexv2models_bot.book_hotel_bot.id
  bot_version = aws_lexv2models_bot_version.book_hotel_bot_version
  locale_id   = aws_lexv2models_bot_locale.book_hotel_bot_locale.id
  name        = "BookHotel"
  description = "Intent to book a hotel"

  confirmation_setting {
    active = true

    prompt_specification {
      allow_interrupt            = true
      max_retries                = 1
      message_selection_strategy = "Ordered"

      prompt_attempts_specification {
        allow_interrupt = true
        map_block_key   = "Initial"

        allowed_input_types {
          allow_audio_input = true
          allow_dtmf_input  = true
        }

        audio_and_dtmf_input_specification {
          start_timeout_ms = 4000

          audio_specification {
            end_timeout_ms = 640
            max_length_ms  = 15000
          }

          dtmf_specification {
            deletion_character = "*"
            end_character      = "#"
            end_timeout_ms     = 5000
            max_length         = 513
          }
        }

        text_input_specification {
          start_timeout_ms = 30000
        }
      }

      prompt_attempts_specification {
        allow_interrupt = true
        map_block_key   = "Retry1"

        allowed_input_types {
          allow_audio_input = true
          allow_dtmf_input  = true
        }

        audio_and_dtmf_input_specification {
          start_timeout_ms = 4000

          audio_specification {
            end_timeout_ms = 640
            max_length_ms  = 15000
          }

          dtmf_specification {
            deletion_character = "*"
            end_character      = "#"
            end_timeout_ms     = 5000
            max_length         = 513
          }
        }

        text_input_specification {
          start_timeout_ms = 30000
        }
      }
    }
  }

  fulfillment_code_hook {
    enabled = true
    active  = true
    fulfillment_updates_specification {
      active = true
      start_response {
        delay_in_seconds = 0
        message_group {
          message {
            plain_text_message {
              value = "Booking your hotel..."
            }
          }
        }
      }
      update_response {
        frequency_in_seconds = 1
        message_group {
          message {
            plain_text_message {
              value = "Still working on booking your hotel."
            }
          }
        }
      }
      timeout_in_seconds = 60
    }
  }
  # sample_utterances = [
  #   "I want to book a hotel",
  #   "Book a hotel in {Location}",
  #   "I need a hotel room in {Location} from {CheckInDate} for {Nights} nights"
  # ]

  # fulfillment_activity {
  #   type = "CodeHook"
  #   code_hook {
  #     message_version = "1.0"
  #     uri             = module.lambda.book_hotel_lambda_invoke_arn
  #   }
  # }


  # slot {
  #   name            = "Location"
  #   slot_constraint = "Required"
  #   slot_type       = "AMAZON.City"
  #   value_elicitation_prompt {
  #     message {
  #       content_type = "PlainText"
  #       content      = "Which city would you like to stay in?"
  #     }
  #     max_attempts = 3
  #   }
  # }
  # slot {
  #   name            = "CheckInDate"
  #   slot_constraint = "Required"
  #   slot_type       = "AMAZON.DATE"
  #   value_elicitation_prompt {
  #     message {
  #       content_type = "PlainText"
  #       content      = "What date will you check in?"
  #     }
  #     max_attempts = 3
  #   }
  # }
  # slot {
  #   name            = "Nights"
  #   slot_constraint = "Required"
  #   slot_type       = "AMAZON.NUMBER"
  #   value_elicitation_prompt {
  #     message {
  #       content_type = "PlainText"
  #       content      = "How many nights will you be staying?"
  #     }
  #     max_attempts = 3
  #   }
  # }

  closing_setting {
    active = true
    closing_response {
      message_group {
        message {
          plain_text_message {
            value = "Thank you, I have booked your hotel."
          }
        }
      }
    }
  }

  dialog_code_hook {
    enabled = true
  }

  fulfillment_code_hook {
    enabled = true
  }


  # confirmation_prompt {
  #   message {
  #     content_type = "PlainText"
  #     content      = "Do you want to book a hotel in {Location} for {Nights} nights starting from {CheckInDate}?"
  #   }
  #   max_attempts = 2
  # }

  # rejection_statement {
  #   message {
  #     content_type = "PlainText"
  #     content      = "Okay, I have cancelled your hotel booking."
  #   }
  # }

  # create_version = true
}

resource "aws_lexv2models_slot" "book_hotel_location_slot" {
  bot_id      = aws_lexv2models_bot.book_hotel_bot.id
  bot_version = aws_lexv2models_bot_version.book_hotel_bot_version
  locale_id   = aws_lexv2models_bot_locale.book_hotel_bot_locale.id
  intent_id   = aws_lexv2models_intent.book_hotel_bot_intent.id
  name        = "Location"
  description = "A city for booking a hotel"
  # value_selection_strategy = "ORIGINAL_VALUE"
  # slot_type = "AMAZON.City"
  # slot_constraint = "Required"
  # priority = 1
  obfuscation_setting {
    obfuscation_setting_type = "None"
  }

}

resource "aws_lexv2models_slot" "book_hotel_checkin_slot" {
  bot_id      = aws_lexv2models_bot.book_hotel_bot.id
  bot_version = aws_lexv2models_bot_version.book_hotel_bot_version
  locale_id   = aws_lexv2models_bot_locale.book_hotel_bot_locale.id
  intent_id   = aws_lexv2models_intent.book_hotel_bot_intent.id
  name        = "CheckInDate"
  description = "Check in date for booking a hotel"
}

resource "aws_lexv2_slot_type" "city_slot_type" {
  slot_type_name = "City"
  bot_id         = aws_lexv2_bot.hotel_booking_bot.id
  bot_version    = aws_lexv2_bot_version.hotel_booking_bot_version.bot_version
  locale_id      = "en_US"

  slot_type_values {
    sample_value {
      value = "New York"
    }
    synonyms = [
      "New York City",
      "NYC"
    ]
  }
  slot_type_values {
    sample_value {
      value = "San Francisco"
    }
    synonyms = [
      "San Francisco",
      "SF"
    ]
  }
  slot_type_values {
    sample_value {
      value = "Seattle"
    }
    synonyms = [
      "Seattle"
    ]
  }
}

resource "aws_lexv2_slot_type" "date_slot_type" {
  slot_type_name = "AMAZON.Date"
  bot_id         = aws_lexv2_bot.hotel_booking_bot.id
  bot_version    = aws_lexv2_bot_version.hotel_booking_bot_version.bot_version
  locale_id      = "en_US"
}

resource "aws_lexv2_slot_type" "number_slot_type" {
  slot_type_name = "AMAZON.Number"
  bot_id         = aws_lexv2_bot.hotel_booking_bot.id
  bot_version    = aws_lexv2_bot_version.hotel_booking_bot_version.bot_version
  locale_id      = "en_US"
}

# resource "aws_lex_slot_type" "book_hotel_city_slot_type" {
#   name        = "City"
#   description = "A city for booking a hotel"
#   enumeration_value {
#     synonyms = [
#       "New York City",
#       "NYC"
#     ]
#     value = "New York"
#   }
#   enumeration_value {
#     synonyms = [
#       "San Francisco",
#       "SF"
#     ]
#     value = "San Francisco"
#   }
#   enumeration_value {
#     synonyms = [
#       "Seattle"
#     ]
#     value = "Seattle"
#   }
# }