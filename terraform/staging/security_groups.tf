module "security_groups" {
  source = "../modules/security_groups"

  public_sg_name   = "public_sg"
  private_sg_name  = "private_sg"
  database_sg_name = "database_sg"
  vpc_id           = module.vpc.vpc_id

  private_cidr_blocks = [var.vpc_cidr]
}
