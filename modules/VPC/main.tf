module "aws_vpc" {
  source = "terraform-aws-modules/vpc/aws"
  name   = "vpc-${var.environment}"
  cidr   = var.cidr

  tags = var.tags

  azs                 = ["${var.region}a", "${var.region}b", "${var.region}c"]
  private_subnets     = ["${cidrsubnet(var.cidr, 8, 0)}", "${cidrsubnet(var.cidr, 8, 1)}", "${cidrsubnet(var.cidr, 8, 2)}"]
  public_subnets      = ["${cidrsubnet(var.cidr, 8, 6)}", "${cidrsubnet(var.cidr, 8, 7)}", "${cidrsubnet(var.cidr, 8, 8)}"]
  database_subnets    = ["${cidrsubnet(var.cidr, 8, 12)}", "${cidrsubnet(var.cidr, 8, 13)}", "${cidrsubnet(var.cidr, 8, 14)}"]
  elasticache_subnets = ["${cidrsubnet(var.cidr, 8, 15)}", "${cidrsubnet(var.cidr, 8, 16)}", "${cidrsubnet(var.cidr, 8, 17)}"]
  intra_subnets       = ["${cidrsubnet(var.cidr, 8, 18)}", "${cidrsubnet(var.cidr, 8, 19)}", "${cidrsubnet(var.cidr, 8, 20)}"]

  private_subnet_tags = {
    Name = "Private-${var.environment}"
  }
  database_subnet_tags = {
    Name = "Database-${var.environment}"
  }
  public_subnet_tags = {
    Name = "Publica-${var.environment}"
  }
  elasticache_subnet_tags = {
    Name = "Elasticache-${var.environment}"
  }
  intra_subnet_tags = {
    Name = "Intra-${var.environment}"
  }

  private_route_table_tags = {
    Name = "private-route-${var.environment}"
  }
  public_route_table_tags = {
    Name = "public-route-${var.environment}"
  }
  database_route_table_tags = {
    Name = "db-route-${var.environment}"
  }
  elasticache_route_table_tags = {
    Name = "elasticache-route-${var.environment}"
  }
  intra_route_table_tags = {
    Name = "intra-route-${var.environment}"
  }

  create_database_subnet_group           = var.create_database_subnet_group
  create_database_subnet_route_table     = var.create_database_subnet_route_table
  create_database_internet_gateway_route = var.create_database_internet_gateway_route
  create_elasticache_subnet_route_table  = var.create_elasticache_subnet_route_table
  one_nat_gateway_per_az                 = var.one_nat_gateway_per_az
  enable_nat_gateway                     = var.enable_nat_gateway
  enable_vpn_gateway                     = var.enable_vpn_gateway
  single_nat_gateway                     = var.single_nat_gateway
  enable_dns_hostnames                   = var.enable_dns_hostnames
  enable_dns_support                     = var.enable_dns_support
  enable_s3_endpoint                     = var.enable_s3_endpoint
  enable_dynamodb_endpoint               = var.enable_dynamodb_endpoint
}

