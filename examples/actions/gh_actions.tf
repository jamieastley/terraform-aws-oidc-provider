terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.74.0"
    }
  }
}

locals {
  identity_provider_base_url = "https://token.actions.githubusercontent.com"
  tags = {
    app = "oidc_provider_example"
  }
}

data "tls_certificate" "github" {
  url = "${local.identity_provider_base_url}/.well-known/openid-configuration"
}

module "oidc_provider" {
  source                = "../../"
  identity_provider_url = local.identity_provider_base_url
  aud_claim_url         = "token.actions.githubusercontent.com:aud"
  iam_role_name         = var.iam_role_name
  oidc_provider_arn_list = ["sts.amazonaws.com"]
  sub_claim_url         = "token.actions.githubusercontent.com:sub"
  sub_claim_list = [
    "repo:jamieastley/terraform-aws-oidc-provider:*",
  ]
  oidc_provider_thumbprint_list = [data.tls_certificate.github.certificates[0].sha1_fingerprint]
  resource_tags = local.tags
}

# Define policy statements for GitHub Actions
data "aws_iam_policy_document" "iam_role_policies" {
  statement {
    effect = "Allow"
    actions = ["s3:*"]
    resources = ["*"]
  }
}

# Create the IAM policy based on the policy document
resource "aws_iam_policy" "iam_policy" {
  name        = "ecr-policy"
  description = "Allows the ECR instance to interact with various AWS services"
  policy      = data.aws_iam_policy_document.iam_role_policies.json
  tags        = local.tags
}

# Attach the policy to the OIDC role
resource "aws_iam_role_policy_attachment" "attach_policy" {
  role       = module.oidc_provider.oidc_role_name
  policy_arn = aws_iam_policy.iam_policy.arn
}
