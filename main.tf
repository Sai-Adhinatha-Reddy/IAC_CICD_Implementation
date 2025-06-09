provider "aws" {
  region = var.region
}

# https://registry.terraform.io/modules/claranet/vpc-modules/aws/latest/submodules/public-subnets?tab=outputs
module "vpc" {
  source  = "claranet/vpc-modules/aws//modules/vpc"
  version = "1.1.1"

  #  name = var.vpc_name
  cidr_block           = var.vpc_cidr_block
  enable_dns_support   = true
  enable_dns_hostnames = true
}

module "public_subnets" {
  source  = "claranet/vpc-modules/aws//modules/public-subnets"
  version = "1.1.1"

  #  name = var.public-subnet-name
  vpc_id                  = module.vpc.vpc_id
  gateway_id              = module.vpc.internet_gateway_id
  map_public_ip_on_launch = true
  cidr_block              = var.public_subnet_cidr_block
  subnet_count            = 1
  availability_zones      = ["us-east-1a", "us-east-1b", "us-east-1c"]
}

# https://registry.terraform.io/modules/terraform-aws-modules/ec2-instance/aws/latest
module "ec2-instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "5.8.0"

  # name = var.ec2_instance_name
  instance_type          = var.instance_type
  key_name               = var.ec2_user
  monitoring             = true
  vpc_security_group_ids = ["${aws_security_group.ssh-allowed.id}"]
  subnet_id              = module.public_subnets.subnet_ids.0

  # nginx installation
  user_data = file("userdata.tpl")

  tags = {
    Name        = var.ec2_instance_name
    Environment = "dev"
  }
}

resource "aws_security_group" "ssh-allowed" {
  vpc_id = module.vpc.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = var.cidr
  }
  ingress {
    from_port = var.port1
    to_port   = var.port1
    protocol  = "tcp"
    // This means, all ip address are allowed to ssh ! 
    // Do not do it in the production. 
    // Put your office or home address in it!
    cidr_blocks = var.cidr
  }
  //If you do not add this rule, you can not reach the NGINX  
  ingress {
    from_port   = var.port2
    to_port     = var.port2
    protocol    = "tcp"
    cidr_blocks = var.cidr
  }

  tags = {
    Name        = "ssh-allowed"
    Environment = "dev"
  }
}
