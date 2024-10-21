resource "aws_iam_role" "vm_role" {
  name = var.vm_role_name
  path = "/"

  force_detach_policies = true

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = "AssumeRoleVM"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })

  tags = var.tags
}

resource "aws_iam_instance_profile" "vm_profile" {
  name = var.instance_profile_name
  role = aws_iam_role.vm_role.name

  tags = var.tags
}

# SSM Access
# Container Registry Access
resource "aws_iam_role_policy_attachment" "vm_aws_managed_policy_attachment" {
  for_each = toset([
    "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly",
    "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore",
    "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy",
    "arn:aws:iam::aws:policy/AmazonSSMPatchAssociation",
  ])
  role       = aws_iam_role.vm_role.name
  policy_arn = each.value
}

# Staging Bucket Access
data "aws_iam_policy_document" "staging_bucket_access" {
  statement {
    sid       = "ListObjectsInStagingBucket"
    effect    = "Allow"
    actions   = ["s3:ListBucket"]
    resources = var.s3_buckets_arn
  }

  statement {
    sid       = "AllObjectActionsInStagingBucket"
    effect    = "Allow"
    actions   = ["s3:*Object*"]
    resources = var.s3_bucket_objects_arn
  }
}

data "aws_iam_policy_document" "vm_execution_policy" {
  source_policy_documents = [data.aws_iam_policy_document.staging_bucket_access.json]
}

resource "aws_iam_policy" "vm_execution_policy" {
  name        = var.vm_execution_policy_name
  description = "VM Execution Policy"
  policy      = data.aws_iam_policy_document.vm_execution_policy.json

  tags = var.tags
}

resource "aws_iam_role_policy_attachment" "s3_execution_policy_attachment" {
  role       = aws_iam_role.vm_role.name
  policy_arn = aws_iam_policy.vm_execution_policy.arn
}
