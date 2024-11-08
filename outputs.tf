output "oidc_role_name" {
  value = aws_iam_role.oidc_role.name                                          # The actual value to be outputted
  description = "The name of the OIDC role which was created"
}