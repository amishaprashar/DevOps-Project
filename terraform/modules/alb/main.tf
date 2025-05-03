data "aws_vpc" "myvpc" {
  filter {
    name   = "cidr-block"
    values = ["10.0.0.0/16"]
  }

}


data "aws_subnet" "subnet-1" {
  filter {
    name   = "cidr-block"
    values = ["10.0.0.0/24"]
  }
}

data "aws_subnet" "subnet-2" {
  filter {
    name   = "cidr-block"
    values = ["10.0.1.0/24"]
  }
}

data "aws_security_group" "web-sg" {
  filter {
    name   = "tag:Name"
    values = ["Web-sg"]
  }
}

data "aws_instance" "instance-1" {
  filter {
    name   = "tag:Name"
    values = ["Frontend-1"]
  }

}

data "aws_instance" "instance-2" {
  filter {
    name   = "tag:Name"
    values = ["Frontend-2"]
  }

}


resource "aws_alb" "myalb" {
  name               = "myalb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [data.aws_security_group.web-sg.id]
  subnets            = [data.aws_subnet.subnet-1.id, data.aws_subnet.subnet-2.id]
  tags = {
    Name = "my-alb"
  }
}

resource "aws_lb_target_group" "tg" {
  name     = "myTG"
  port     = 80
  protocol = "HTTP"
  vpc_id   = data.aws_vpc.myvpc.id

  health_check {
    path = "/"
    port = "traffic-port"
  }

}

resource "aws_lb_target_group_attachment" "attach1" {
  target_group_arn = aws_lb_target_group.tg.arn
  target_id        = data.aws_instance.instance-1.id
  port             = 80

}

resource "aws_lb_target_group_attachment" "attach2" {
  target_group_arn = aws_lb_target_group.tg.arn
  target_id        = data.aws_instance.instance-2.id
  port             = 80

}

resource "aws_lb_listener" "listener" {
  load_balancer_arn = aws_alb.myalb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_lb_target_group.tg.arn
    type             = "forward"
  }

}

output "loadbalancerdns" {
  value = aws_alb.myalb.dns_name
}