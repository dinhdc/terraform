resource "aws_iam_user" "users" {
  name  = var.users_created[count.index]
  count = length(var.users_created)
}

resource "aws_iam_access_key" "access_keys" {
  count = length(var.users_created)
  user  = aws_iam_user.users[count.index].name
}

output "access_key_id" {
  value = aws_iam_access_key.access_keys[*].id
}

output "secret_access_key" {
  value = aws_iam_access_key.access_keys[*].secret
  sensitive = true
}