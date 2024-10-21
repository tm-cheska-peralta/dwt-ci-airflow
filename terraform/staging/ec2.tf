module "ec2" {
  source = "../modules/ec2"

  instance_type          = var.instance_type
  vm_name                = var.vm_name
  environment            = var.environment
  subnet_id              = module.vpc.private_subnets[0]
  vpc_security_group_ids = [module.security_groups.security_group_private]
  iam_instance_profile   = module.iam.instance_profile_name

  user_data = var.user_data

  tags = local.common_tags
}
