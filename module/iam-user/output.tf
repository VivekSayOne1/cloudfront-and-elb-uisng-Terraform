output "iam-user" {
  
  value = aws_iam_user.iam-user.id
}
output "password" {
  value = aws_iam_user_login_profile.password-iam.encrypted_password
}
