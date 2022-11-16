terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.36.0"
    }
  }
}

provider "aws" {
  # Configuration options
  region = "ap-south-1"
}


resource "aws_iam_user" "github" {
  name = "userfromgithub"

  tags = {
    tag-key = "github-user"
  }
}

resource "aws_iam_access_key" "github-key" {
  user = aws_iam_user.github.name
}

resource "aws_iam_user_policy" "github-policy" {
  name = "userpolicygithub"
  user = aws_iam_user.github.name

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "ec2:Describe*"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}
