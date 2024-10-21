module "vpc" {
  source = "../modules/vpc"

  vpc_name = "${var.vpc_name}-${var.environment}"
  vpc_cidr = var.vpc_cidr

  vpc_azs          = var.vpc_azs
  database_subnets = var.vpc_database_subnets
  private_subnets  = var.vpc_private_subnets
  public_subnets   = var.vpc_public_subnets

  enable_nat_gateway = var.enable_nat_gateway

  tags = local.common_tags

  enable_flow_log          = var.enable_flow_log
  flow_log_destination_arn = module.logs_bucket.arn

}
