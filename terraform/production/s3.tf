module "staging_bucket" {
  source = "../modules/s3"

  bucket_name = local.bucket_name

  tags = local.common_tags
}

module "logs_bucket" {
  source = "../modules/s3"

  bucket_name = local.flow_logs_bucket_name

  attach_policy = true
  policy        = data.aws_iam_policy_document.flow_log_s3.json

  tags = local.common_tags
}

data "aws_iam_policy_document" "flow_log_s3" {
  statement {
    sid = "AWSLogDeliveryWrite"

    principals {
      type        = "Service"
      identifiers = ["delivery.logs.amazonaws.com"]
    }

    actions = ["s3:PutObject"]

    resources = ["arn:aws:s3:::${local.flow_logs_bucket_name}/AWSLogs/*"]
  }

  statement {
    sid = "AWSLogDeliveryAclCheck"

    principals {
      type        = "Service"
      identifiers = ["delivery.logs.amazonaws.com"]
    }

    actions = ["s3:GetBucketAcl"]

    resources = ["arn:aws:s3:::${local.flow_logs_bucket_name}"]
  }
}
