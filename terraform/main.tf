module "vpc" {
    source = "./modules/vpc"
    region = var.region
    cidr_block = var.cidr_block
    public_subnet_cidr = var.public_subnet_cidr
    public_subnet_2_cidr = var.public_subnet_2_cidr
    availability_zone_1 = var.availability_zone_1
    availability_zone_2 = var.availability_zone_2
}

module "ec2" {
    source = "./modules/ec2"
    region = var.region
    ami = "ami-0e35ddab05955cf57"
    instance_type = "t2.micro"
}

module "alb" {
    source = "./modules/alb"
    region = var.region
}