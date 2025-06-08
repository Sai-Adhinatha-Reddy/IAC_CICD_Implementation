variable "region" {
  default = "us-east-1"
}

variable "vpc_cidr_block" {
    default = "10.0.0.0/16"
}

variable "public_subnet_cidr_block" {
    default = "10.0.1.0/24"
}

variable "ec2_instance_name" {
    default = "CICD_Assignment_4"
}

variable "instance_type" {
    default = "t2.micro"
}

variable "ec2_user" {
    default = ${{ secrets.EC2_User }}
}

variable "port1" {
    default = 22
}

variable "port2" {
    default = 80
}

variable "cidr" {
  type    = list(string)
  default = ["0.0.0.0/0"]
}

variable "vpc_name" {
  default     = "dev-vpc"
}

variable "public-subnet-name" {
  default     = "pub-sub-1"
}