module "iam" {
  source = "../modules/iam"

  vm_role_name             = local.vm_role_name
  instance_profile_name    = local.instance_profile_name
  vm_execution_policy_name = local.vm_execution_policy_name
  tags                     = local.common_tags

  s3_buckets_arn        = [module.staging_bucket.arn]
  s3_bucket_objects_arn = ["${module.staging_bucket.arn}/*"]
}
