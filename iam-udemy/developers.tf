resource "aws_iam_group_policy" "developers_policy" {
  group = aws_iam_group.developers.name
  name  = "developers_policy"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "iam:GenerateCredentialReport",
          "iam:GenerateServiceLastAccessedDetails",
          "iam:Get*",
          "iam:List*"
        ],
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_group" "developers" {
  name = "developers"
}


resource "aws_iam_group_membership" "developers_membership" {
  group = aws_iam_group.developers.name
  name  = "developers_membership"
  users = [
    aws_iam_user.users[0].name,
    aws_iam_user.users[1].name,
    aws_iam_user.users[2].name
  ]
}