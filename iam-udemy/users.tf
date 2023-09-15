resource "aws_iam_user" "users" {
  name  = var.users_created[count.index]
  count = length(var.users_created)
}

resource "aws_iam_access_key" "access_keys" {
  count = length(var.users_created)
  user  = aws_iam_user.users[count.index].name
}

#resource "aws_secretsmanager_secret" "users_password_secret" {
#  name  = "users_password_secret_${var.users_created[count.index]}"
#  count = length(var.users_created)
#}
#
#resource "random_password" "users_password" {
#  count = length(var.users_created)
#  length = 16
#  special = true
#  override_special = "!@#$%^"
#}
#
#resource "aws_secretsmanager_secret_version" "users_password_version" {
#  count         = length(var.users_created)
#  secret_id     = aws_secretsmanager_secret.users_password_secret[count.index].id
#  secret_string = random_password.users_password[count.index].result
#}

output "access_key_id" {
  value = aws_iam_access_key.access_keys[*].id
}

output "secret_access_key" {
  value     = aws_iam_access_key.access_keys[*].secret
  sensitive = true
}

resource "aws_iam_user_login_profile" "profiles" {
  count = length(var.users_created)
  user  = aws_iam_user.users[count.index].name
  password_reset_required = true
}

output "password" {
  value = aws_iam_user_login_profile.profiles[*].encrypted_password
}

#output "initial_password_secret_arn" {
#  value = aws_secretsmanager_secret.users_password_secret[*].arn
#}