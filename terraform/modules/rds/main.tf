resource "aws_db_instance" "rds" {
  identifier     = var.identifier
  instance_class = var.instance_class

  db_name  = var.db_name
  username = var.db_username
  password = var.db_password
  port     = var.port

  engine         = var.engine
  engine_version = var.engine_version

  allocated_storage     = var.allocated_storage
  max_allocated_storage = var.max_allocated_storage

  storage_encrypted = var.storage_encrypted

  multi_az               = var.multi_az
  availability_zone      = var.availability_zone
  db_subnet_group_name   = aws_db_subnet_group.database.name
  vpc_security_group_ids = var.vpc_security_group_ids

  deletion_protection       = var.deletion_protection
  skip_final_snapshot       = var.skip_final_snapshot
  final_snapshot_identifier = var.final_snapshot_identifier

  tags = var.tags
}

resource "aws_db_subnet_group" "database" {
  name       = "${var.identifier}-subnet-group"
  subnet_ids = var.database_subnet_ids

  tags = {
    Name = "${var.identifier}-subnet-group"
  }
}

resource "aws_db_parameter_group" "database" {
  count = var.create_parameter_group ? 1 : 0

  name   = "${var.identifier}-parameter-group"
  family = var.family

  dynamic "parameter" {
    for_each = var.parameters
    content {
      name  = parameter.value.name
      value = parameter.value.value
    }
  }
}