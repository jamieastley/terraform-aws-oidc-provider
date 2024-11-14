output "oidc_provider_arn" {
  value       = aws_iam_openid_connect_provider.oidc_provider.arn
  description = "The ARN of the OIDC provider which was created"
}