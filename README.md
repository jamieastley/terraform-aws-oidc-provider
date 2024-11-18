# terraform-aws-oidc-provider

A Terraform module to create an OpenID Connect (OIDC) provider in AWS, and to configure
roles and policies against it.

Creating the OIDC provider is a one-off process so if you already have one configured, the
`oidc-provider` submodule can be skipped, and you can instead provide an existing provider's ARN to
the module via the `oidc_provider_arn_list` input variable.

## Usage

See the [examples](./examples) directory for usage examples of how to implement these modules.

The policy below lists the minimum-required permissions for the module:

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "VisualEditor0",
      "Effect": "Allow",
      "Action": [
        "iam:CreatePolicy",
        "iam:DetachRolePolicy",
        "iam:DeletePolicy",
        "iam:CreateRole",
        "iam:DeleteRole",
        "iam:AttachRolePolicy",
        "iam:DeleteOpenIDConnectProvider",
        "iam:CreateOpenIDConnectProvider"
      ],
      "Resource": "*"
    }
  ]
}
```


