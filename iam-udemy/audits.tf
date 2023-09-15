resource "aws_iam_group_policy" "audits_policy" {
  group = aws_iam_group.audits.name
  name  = "audits_policy"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect   = "Allow",
        Action   = "*",
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_group" "audits" {
  name = "audits"
}


resource "aws_iam_group_membership" "audits_membership" {
  group = aws_iam_group.audits.name
  name  = "audits_membership"
  users = [
    aws_iam_user.users[2].name,
    aws_iam_user.users[3].name
  ]
}