output "vpc_id" {
  value = aws_vpc.myvpc.id
}

output "public_subnet_1_id" {
  value = aws_subnet.my-subnet-1.id
}

output "public_subnet_2_id" {
  value = aws_subnet.my-subnet-2.id
}

output "web_sg_id" {
  value = aws_security_group.web-sg.id
}
