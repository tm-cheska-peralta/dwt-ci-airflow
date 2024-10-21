terraform {
  backend "s3" {
    encrypt        = true
    bucket         = "dpd-de-sandbox-tf-state-production"
    key            = "aws/terraform.tfstate"
    region         = "us-west-2"
    dynamodb_table = "dwh-terraform-lock-production"
    profile        = "production-account"
  }
}
