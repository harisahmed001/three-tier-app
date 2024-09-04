data "aws_caller_identity" "current" {}

resource "aws_iam_role" "github_role" {
  name = "${var.name}-github-role"
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : {
          "Federated" : "arn:aws:iam::${data.aws_caller_identity.current.id}:oidc-provider/token.actions.githubusercontent.com"
        },
        "Action" : "sts:AssumeRoleWithWebIdentity",
        "Condition" : {
          "StringLike" : {
            "token.actions.githubusercontent.com:sub" : "repo:harisahmed001/three-tier-app:*"
          }
        }
      }
    ]
  })

  inline_policy {
    name = "${var.name}-github-policy"

    policy = jsonencode({
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Resource" : [
            "${aws_s3_bucket.website_bucket.arn}",
            "${aws_s3_bucket.website_bucket.arn}/*"
          ],
          "Effect" : "Allow",
          "Action" : [
            "s3:DeleteObject",
            "s3:GetBucketLocation",
            "s3:GetObject",
            "s3:ListBucket",
            "s3:PutObject",
            "s3:PutObjectAcl",
            "s3:ListObjects"
          ]
        },
        {
          "Effect" : "Allow",
          "Resource" : "${aws_ecr_repository.ecr_aws_ecr_repository.arn}",
          "Action" : [
                "ecr:InitiateLayerUpload",
                "ecr:UploadLayerPart",
                "ecr:CompleteLayerUpload",
                "ecr:BatchCheckLayerAvailability",
                "ecr:PutImage"
            ]
        },
        {
          "Effect" : "Allow",
          "Resource" : "${module.eks.arn}",
          "Action" : [
                "ecr:DescribeCLuster"
            ]
        }
      ]
    })
  }

  tags = {
    Name  = "Github Role"
  }
}
