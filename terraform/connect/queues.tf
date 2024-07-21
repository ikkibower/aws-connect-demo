resource "aws_connect_queue" "test_queue" {
  depends_on            = [aws_connect_hours_of_operation.office_hours, aws_connect_instance.test_connect_instance]
  instance_id           = aws_connect_instance.test_connect_instance.id
  name                  = "TestQueue"
  description           = "Test queue"
  hours_of_operation_id = aws_connect_hours_of_operation.office_hours.id

  tags = {
    "Name" = "TestQueue",
  }
}