resource "aws_connect_hours_of_operation" "office_hours" {
  instance_id = aws_connect_instance.test_connect_instance.id
  name        = "OfficeHours"
  description = "Office hours M-F 8AM-5PM CST"
  time_zone   = "America/Chicago"

  config {
    day = "MONDAY"
    start_time {
      hours   = 8
      minutes = 0
    }
    end_time {
      hours   = 17
      minutes = 0
    }
  }

  config {
    day = "TUESDAY"
    start_time {
      hours   = 8
      minutes = 0
    }
    end_time {
      hours   = 17
      minutes = 0
    }
  }

  config {
    day = "WEDNESDAY"
    start_time {
      hours   = 8
      minutes = 0
    }
    end_time {
      hours   = 17
      minutes = 0
    }
  }

  config {
    day = "THURSDAY"
    start_time {
      hours   = 8
      minutes = 0
    }
    end_time {
      hours   = 17
      minutes = 0
    }
  }

  config {
    day = "FRIDAY"
    start_time {
      hours   = 8
      minutes = 0
    }
    end_time {
      hours   = 17
      minutes = 0
    }
  }

  tags = {
    Name = "OfficeHours"
  }
}