terraform {
  backend "s3" {
    encrypt        = true
    bucket         = "dpd-de-sandbox-tf-state-staging"
    key            = "aws/terraform.tfstate"
    region         = "us-west-2"
    dynamodb_table = "dwh-terraform-lock-staging"
    profile        = "staging-account"
  }
}
