output "connect_prompts_table_arn" {
  value = aws_dynamodb_table.connect_prompts.arn
}

output "hotel_bookings_table_arn" {
  value = aws_dynamodb_table.hotel_bookings.arn
}