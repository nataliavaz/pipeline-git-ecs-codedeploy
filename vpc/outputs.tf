output "vpc_id" {
  value = module.vpc.vpc_id
}

output "vpc_cidr_block" {
  description = "The CIDR block of the VPC"
  value       = concat(module.vpc.*.vpc_cidr_block, [""])[0]
}

output "database_subnets" {
  description = "List of IDs of database subnets"
  value       = concat(module.vpc.*.database_subnets, [""])[0]
}

output "elasticache_subnets" {
  description = "List of IDs of elasticache subnets"
  value       = concat(module.vpc.*.elasticache_subnets, [""])[0]
}

output "private_subnets" {
  description = "List of IDs of private subnets"
  value       = concat(module.vpc.*.private_subnets, [""])[0]
}
output "public_subnets" {
  description = "List of IDs of public subnets"
  value       = concat(module.vpc.*.public_subnets, [""])[0]
}