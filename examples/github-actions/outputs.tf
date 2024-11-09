output "role_arn" {
  value       = module.oidc_policies.oidc_role_arn
  description = "The ARN of the OIDC role which was created"
}