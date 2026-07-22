resource "aws_iam_user" "Developer-1" {
  name = "Backend-Dev"

  tags = merge(local.common_tags, {
    role = "Dev-1"
  })

}

resource "random_password" "dynamic_password" {
  length  = var.password_lenght
  special = true
  upper   = true
  lower   = true
  numeric = true

}


resource "aws_iam_user_login_profile" "Developer-1-loginprofile" {
  user                    = aws_iam_user.Developer-1.name
  password_reset_required = true

}

resource "aws_iam_access_key" "Developer_access_key" {
  user = aws_iam_user.Developer-1.name
}

resource "aws_ssm_parameter" "access_key_security" {
  name      = "/${var.project}/access_key_id"
  type      = "SecureString"
  value     = aws_iam_access_key.Developer_access_key.id
  overwrite = true

  tags = merge(local.common_tags,
    {
      Name = "${var.project}-ssm"
  })
}

resource "aws_ssm_parameter" "secret_access_key" {
  name      = "/${var.project}/secre_access_key"
  type      = "SecureString"
  value     = aws_iam_access_key.Developer_access_key.secret
  overwrite = true
  tags = merge(local.common_tags,
    {
      Name = "${var.project}-ssm"
  })
}

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

resource "aws_iam_policy" "ec2_access" {
  name = "EC2Access"
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid    = "EC2require"
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
          "ec2:DescribeNetworkInterfaces"
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
