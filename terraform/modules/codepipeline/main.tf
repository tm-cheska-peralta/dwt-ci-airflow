resource "aws_iam_role" "codepipeline_role" {
  name = var.iam_role_name
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "codepipeline.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_policy_attachment" "codepipeline_role_policy" {
  name       = "codepipeline-policy-attachment"
  roles      = [aws_iam_role.codepipeline_role.name]
  policy_arn = "arn:aws:iam::aws:policy/AWSCodePipeline_FullAccess"
}

resource "aws_iam_role_policy" "codepipeline_inline_policy" {
  name = "codepipeline-inline-policy"
  role = aws_iam_role.codepipeline_role.name
  policy = jsonencode(
    {
      "Version": "2012-10-17",
      "Statement": [
        {
          "Effect": "Allow",
          "Action": [
              "codestar-connections:*",
              "s3:*",
              "codedeploy:*"
          ],
          "Resource": "*"
        }
      ]
    }
  )
}

resource "aws_codepipeline" "pipeline" {
  name     = var.pipeline_name
  role_arn = aws_iam_role.codepipeline_role.arn
  artifact_store {
    location = var.external_s3_bucket
    type     = "S3"
  }

  dynamic "stage" {
    for_each = var.pipeline_stages
    content {
      name = stage.value.name

      dynamic "action" {
        for_each = stage.value.actions
        content {
          name             = action.value.name
          category         = action.value.category
          owner            = action.value.owner
          provider         = action.value.provider
          version          = action.value.version
          input_artifacts  = action.value.input_artifacts
          output_artifacts = action.value.output_artifacts
          configuration    = action.value.configuration
        }
      }
    }
  }
}
