variable "identity_provider_url" {
  description = "The URL of the identity provider"
  type        = string
  nullable    = false
}

variable "oidc_provider_arn_list" {
  description = "The ARN of the OIDC provider"
  type = list(string)
  nullable    = false
}

variable "identity_provider_client_id_list" {
  description = "The list of client IDs"
  type = list(string)
  default = ["sts.amazonaws.com"]
}

variable "aud_claim_url" {
  description = "The URL of the audience claim"
  type        = string
}

variable "aud_claim_list" {
  description = "The list of audience claims"
  type = list(string)
  default = ["sts.amazonaws.com"]
}

variable "sub_claim_url" {
  description = "The URL of the subject claim"
  type        = string
}

variable "sub_claim_list" {
  description = "The list of subject claims"
  type = list(string)
}

variable "oidc_provider_thumbprint_list" {
  description = "(Optional) A list of server certificate thumbprints for the OpenID Connect (OIDC) identity provider"
  type = list(string)
  default = []
}

variable "iam_role_name" {
  description = "The name given to the IAM role which will be created"
  type        = string
}

variable "resource_tags" {
  description = "A map of tags to add to the resources"
  type = map(string)
}