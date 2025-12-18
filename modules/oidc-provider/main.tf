terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.27"
    }
  }
}

resource "aws_iam_openid_connect_provider" "oidc_provider" {
  url = var.identity_provider_url

  client_id_list = var.identity_provider_client_id_list

  thumbprint_list = var.oidc_provider_thumbprint_list

  tags = var.resource_tags
}
