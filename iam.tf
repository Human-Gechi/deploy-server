#IAM role provisioning

#IAM user
resource "aws_iam_user" "Developer-1" {
  name = "Backend-Dev"

  tags = merge(local.common_tags, {
    role = "Dev-1"
  })
}

resource "aws_iam_access_key" "Developer_access_key" {
  user = aws_iam_user.Developer-1.name
}


resource "aws_ssm_parameter" "access_key_security" {
  name      = "/${var.project}/access_key_id"
  type      = "SecureString"
  value     = aws_iam_access_key.Developer_access_key.id
  overwrite = true

  tags = merge(local.common_tags, {
    Name = "${var.project}-ssm"
  })
}

resource "aws_ssm_parameter" "secret_access_key" {
  name      = "/${var.project}/secret_access_key"
  type      = "SecureString"
  value     = aws_iam_access_key.Developer_access_key.secret
  overwrite = true

  tags = merge(local.common_tags, {
    Name = "${var.project}-ssm"
  })
}

#IAM user policy
resource "aws_iam_user_policy" "iam_access" {
  name = "IAMAccess"
  user = aws_iam_user.Developer-1.name

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid    = "iambasics",
        Effect = "Allow",
        Action = [
          "iam:GetUser",
          "iam:ListAccessKeys",
          "iam:GetAccessKeyLastUsed"
        ],
        Resource = "arn:aws:iam::*:user/${aws_iam_user.Developer-1.name}"
      }
    ]
  })
}

resource "aws_iam_user_policy" "s3_object_access" {
  name = "S3ObjectAccess"
  user = aws_iam_user.Developer-1.name

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect   = "Allow",
        Action   = ["s3:ListAllMyBuckets"],
        Resource = "*" 
      },
      {
        Effect = "Allow",
        Action = [
          "s3:ListBucket",
          "s3:PutBucketTagging"
        ],
        Resource = [
          "arn:aws:s3:::${aws_s3_bucket.web_server_bucket.id}" 
        ]
      },
      {
        Effect = "Allow",
        Action = [
          "s3:GetObject",
          "s3:PutObject",
          "s3:DeleteObject",
          "s3:GetObjectTagging"
        ],
        Resource = [
          "arn:aws:s3:::${aws_s3_bucket.web_server_bucket.id}/*" 
        ]
      }
    ]
  })
}

resource "aws_iam_policy" "ec2_access" {
  name = "EC2-ACCESS"
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid    = "EC2require",
        Effect = "Allow",
        Action = [
          "ec2:CreateVpc",
          "ec2:DescribeVpcs",
          "ec2:DescribeVpcAttribute",
          "ec2:CreateSubnet",
          "ec2:DescribeSubnets",
          "ec2:CreateInternetGateway",
          "ec2:AttachInternetGateway",
          "ec2:DescribeInternetGateways",
          "ec2:CreateRouteTable",
          "ec2:AssociateRouteTable",
          "ec2:CreateRoute",
          "ec2:DescribeRouteTables",
          "ec2:CreateSecurityGroup",
          "ec2:AuthorizeSecurityGroupIngress",
          "ec2:AuthorizeSecurityGroupEgress",
          "ec2:DescribeSecurityGroups",
          "ec2:CreateTags",
          "ec2:DescribeNetworkInterfaces",
          "ec2:DescribeInstances"
        ],
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_user_policy_attachment" "ec2_access" {
  user       = aws_iam_user.Developer-1.name
  policy_arn = aws_iam_policy.ec2_access.arn
}