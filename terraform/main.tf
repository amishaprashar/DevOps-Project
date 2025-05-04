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
    ami = var.ami
    instance_type = var.instance_type
    subnet_id_1 = module.vpc.public_subnet_1_id
    subnet_id_2 = module.vpc.public_subnet_2_id
    security_group_id = module.vpc.web_sg_id
}

module "alb" {
    source = "./modules/alb"
    region = var.region
    vpc_id = module.vpc.vpc_id
    subnet_ids = [module.vpc.public_subnet_1_id,module.vpc.public_subnet_2_id]
    security_group_id = module.vpc.web_sg_id
    instance_1 = module.ec2.instance-id-1
    instance_2 = module.ec2.instance-id-2
}