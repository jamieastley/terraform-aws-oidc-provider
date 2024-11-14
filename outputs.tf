output "oidc_role_name" {
  value       = aws_iam_role.oidc_role.name
  description = "The name of the OIDC role which was created"
}

output "oidc_role_arn" {
  value       = aws_iam_role.oidc_role.arn
  description = "The ARN of the OIDC role which was created"
}