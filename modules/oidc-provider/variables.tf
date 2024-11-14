variable "identity_provider_url" {
  description = "The URL of the identity provider"
  type        = string
  nullable    = false
}

variable "identity_provider_client_id_list" {
  description = "The list of client IDs"
  type        = list(string)
  default     = ["sts.amazonaws.com"]
}

variable "oidc_provider_thumbprint_list" {
  description = "(Optional) A list of server certificate thumbprints for the OpenID Connect (OIDC) identity provider"
  type        = list(string)
  default     = []
}

variable "resource_tags" {
  description = "A map of tags to add to the resources"
  type        = map(string)
}