terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.8"
    }
  }
}

locals {
  app_name                   = "example-github-actions"
  identity_provider_base_url = "https://token.actions.githubusercontent.com"
  tags = {
    app = local.app_name
  }
}

data "tls_certificate" "github" {
  url = "${local.identity_provider_base_url}/.well-known/openid-configuration"
}

module "oidc_provider" {
  source                        = "../../modules/oidc-provider"
  identity_provider_url         = local.identity_provider_base_url
  oidc_provider_thumbprint_list = [data.tls_certificate.github.certificates[0].sha1_fingerprint]
  resource_tags                 = local.tags
}

module "oidc_policies" {
  source                 = "../../"
  aud_claim_url          = "token.actions.githubusercontent.com:aud"
  aud_claim_list         = ["sts.amazonaws.com"]
  iam_role_name          = "${local.app_name}-oidc-role"
  oidc_provider_arn_list = [module.oidc_provider.oidc_provider_arn]
  sub_claim_url          = "token.actions.githubusercontent.com:sub"
  sub_claim_list = [
    "repo:jamieastley/terraform-aws-oidc-provider:*",
  ]
  resource_tags = local.tags
}

# Define policy statements for GitHub Actions
data "aws_iam_policy_document" "iam_role_policies" {
  statement {
    effect    = "Allow"
    actions   = ["s3:*"]
    resources = ["*"]
  }
}

# Create the IAM policy based on the policy document
resource "aws_iam_policy" "iam_policy" {
  name        = "${local.app_name}-s3-policy"
  description = "Allows full access to S3"
  policy      = data.aws_iam_policy_document.iam_role_policies.json
  tags        = local.tags
}

# Attach the policy to the OIDC role
resource "aws_iam_role_policy_attachment" "attach_policy" {
  role       = module.oidc_policies.oidc_role_name
  policy_arn = aws_iam_policy.iam_policy.arn
}
