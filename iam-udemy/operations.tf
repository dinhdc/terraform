resource "aws_iam_group_policy" "operations_policy" {
  group = aws_iam_group.developers.name
  name  = "operations_policy"

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

resource "aws_iam_group" "operations" {
  name = "operations"
}


resource "aws_iam_group_membership" "operations_membership" {
  group = aws_iam_group.operations.name
  name  = "operations_membership"
  users = [
    aws_iam_user.users[3].name,
    aws_iam_user.users[4].name
  ]
}