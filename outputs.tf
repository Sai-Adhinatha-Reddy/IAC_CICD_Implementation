output "vpc_id" {
  value = module.vpc.vpc_id
}

output "internet_gateway_id" {
  value = module.vpc.internet_gateway_id
}

/*
output "route_table_ids" {
  value = module.vpc.route_table_ids
}
*/

output "subnet_ids" {
  value = module.public_subnets.subnet_ids
}

output "ec2_instance_id" {
  value = module.ec2_instance.id
}




