terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.21"
    }
  }
}

data "aws_iam_policy_document" "oidc_policy" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRoleWithWebIdentity"]
    principals {
      type        = "Federated"
      identifiers = var.oidc_provider_arn_list
    }
    condition {
      test     = "StringEquals"
      variable = var.aud_claim_url
      values   = var.aud_claim_list
    }
    condition {
      test     = "StringLike"
      variable = var.sub_claim_url
      values   = var.sub_claim_list
    }
  }
}

resource "aws_iam_role" "oidc_role" {
  name               = var.iam_role_name
  assume_role_policy = data.aws_iam_policy_document.oidc_policy.json
  tags               = var.resource_tags
}
