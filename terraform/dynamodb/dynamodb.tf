resource "aws_dynamodb_table" "connect_prompts" {
  name         = "connect-prompts"
  billing_mode = "PAY_PER_REQUEST"

  attribute {
    name = "node"
    type = "S"
  }

  hash_key = "node"

  tags = {
    Environment = "production"
    Name        = "ConnectPromptsTable"
  }
}

resource "aws_dynamodb_table_item" "connect_prompt_example_item" {
  table_name = aws_dynamodb_table.connect_prompts.name
  hash_key   = "node"

  item = <<ITEM
{
  "node": {"S": "example-prompt-node"},
  "prompt_data": {
    "M": {
      "text": {"S": "Welcome to our service. How can we assist you today?"},
      "audio": {"S": "https://example.com/welcome.mp3"},
      "locale": {"S": "en-US"}
    }
  }
}
ITEM
}


resource "aws_dynamodb_table" "hotel_bookings" {
  name         = "hotel-bookings"
  billing_mode = "PAY_PER_REQUEST"

  attribute {
    name = "node"
    type = "S"
  }

  hash_key = "node"

  tags = {
    Environment = "production"
    Name        = "HotelBookingsTable"
  }
}

resource "aws_dynamodb_table_item" "hotel_booking_example_item" {
  table_name = aws_dynamodb_table.hotel_bookings.name
  hash_key   = "node"

  item = <<ITEM
{
  "node": {"S": "example-hotel-booking-node"},
  "booking_data": {
    "M": {
      "city": {"S": "New York"},
      "check_in": {"S": "2024-11-01"},
      "nights": {"S": "3"}
    }
  }
}
ITEM
}