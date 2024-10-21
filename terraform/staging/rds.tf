module "rds" {
  source = "../modules/rds"

  identifier     = var.identifier
  instance_class = var.instance_class

  db_name     = var.db_name
  db_username = var.db_username
  db_password = var.db_password
  port        = var.port

  engine                = var.engine
  engine_version        = var.engine_version
  family                = var.family
  allocated_storage     = var.allocated_storage
  max_allocated_storage = var.max_allocated_storage
  storage_encrypted     = var.storage_encrypted

  availability_zone      = var.vpc_azs[0]
  database_subnet_ids    = module.vpc.database_subnets
  vpc_security_group_ids = [module.security_groups.security_group_database]

  deletion_protection       = var.deletion_protection
  skip_final_snapshot       = var.skip_final_snapshot
  final_snapshot_identifier = var.final_snapshot_identifier

  tags = local.common_tags
}
