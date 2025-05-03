data "aws_subnet" "subnet_id" {
    filter {
    name   = "cidr-block"
    values = ["10.0.0.0/24"]
  }
  
}

data "aws_subnet" "subnet_id_2" {
    filter {
    name   = "cidr-block"
    values = ["10.0.1.0/24"]
  }
  
}

data "aws_security_group" "web-sg" {
    filter {
      name = "tag:Name"
      values = ["Web-sg"]
    }  
}
 
resource "aws_instance" "instance-1" {
    ami = var.ami
    instance_type = var.instance_type
    security_groups = [data.aws_security_group.web-sg.id]
    subnet_id = data.aws_subnet.subnet_id.id
    user_data = base64encode(file("userdata1.sh"))
    tags = {
        Name = "Frontend-1"
    }
}

resource "aws_instance" "my-instance-2" {
    ami = var.ami
    instance_type = var.instance_type
    security_groups = [data.aws_security_group.web-sg.id]
    subnet_id = data.aws_subnet.subnet_id_2.id
    user_data = base64encode(file("userdata2.sh"))
    tags = {
        Name = "Frontend-2"
    }
}