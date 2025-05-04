resource "aws_instance" "instance-1" {
    ami = var.ami
    instance_type = var.instance_type
    security_groups = [var.security_group_id]
    subnet_id = var.subnet_id_1
    user_data = base64encode(file("./modules/ec2/userdata1.sh"))
    tags = {
        Name = "Frontend-1"
    }
}

resource "aws_instance" "instance-2" {
    ami = var.ami
    instance_type = var.instance_type
    security_groups = [var.security_group_id]
    subnet_id = var.subnet_id_2
    user_data = base64encode(file("./modules/ec2/userdata2.sh"))
    tags = {
        Name = "Frontend-2"
    }
}