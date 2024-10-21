###
# Public Security Group
##

resource "aws_security_group" "public" {
  name        = var.public_sg_name
  description = "Public internet access"
  vpc_id      = var.vpc_id

  tags = var.public_sg_tags
}

resource "aws_security_group_rule" "public_out" {
  type        = "egress"
  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = aws_security_group.public.id
}

resource "aws_security_group_rule" "public_in_ssh" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = var.public_cidr_blocks
  security_group_id = aws_security_group.public.id
}

resource "aws_security_group_rule" "public_in_http" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = var.public_cidr_blocks
  security_group_id = aws_security_group.public.id
}

resource "aws_security_group_rule" "public_in_https" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = var.public_cidr_blocks
  security_group_id = aws_security_group.public.id
}

###
# Private Security Group
##

resource "aws_security_group" "private" {
  name        = var.private_sg_name
  description = "Private internet access"
  vpc_id      = var.vpc_id

  tags = var.private_sg_tags
}

resource "aws_security_group_rule" "private_out" {
  type        = "egress"
  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = aws_security_group.private.id
}

resource "aws_security_group_rule" "private_in" {
  type        = "ingress"
  from_port   = 0
  to_port     = 65535
  protocol    = "-1"
  cidr_blocks = var.private_cidr_blocks

  security_group_id = aws_security_group.private.id
}

###
# Database Security Group
##

resource "aws_security_group" "database" {
  name        = var.database_sg_name
  description = "Database access"
  vpc_id      = var.vpc_id

  tags = var.database_sg_tags
}

resource "aws_security_group_rule" "database_out" {
  type        = "egress"
  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = aws_security_group.database.id
}

resource "aws_security_group_rule" "database_in" {
  type      = "ingress"
  from_port = 0
  to_port   = 65535
  protocol  = "-1"

  source_security_group_id = aws_security_group.private.id

  security_group_id = aws_security_group.database.id
}