resource "aws_connect_routing_profile" "test_routing_profile" {
  instance_id               = aws_connect_instance.test_connect_instance.id
  name                      = "TestRoutingProfile"
  default_outbound_queue_id = aws_connect_queue.test_queue.id
  description               = "Test routing profile"

  media_concurrencies {
    channel     = "VOICE"
    concurrency = 1
  }

  queue_configs {
    channel  = "VOICE"
    delay    = 2
    priority = 1
    queue_id = aws_connect_queue.test_queue.id
  }

  tags = {
    "Name" = "Test Routing Profile",
  }
}