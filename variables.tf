variable "oidc_provider_arn_list" {
  description = "The ARN of the OIDC provider"
  type        = list(string)
  nullable    = false
}

variable "aud_claim_url" {
  description = "The URL of the audience claim"
  type        = string
  nullable    = false
}

variable "aud_claim_list" {
  description = "The list of audience claims"
  type        = list(string)
  default     = ["sts.amazonaws.com"]
}

variable "sub_claim_url" {
  description = "The URL of the subject claim"
  type        = string
  nullable    = false
}

variable "sub_claim_list" {
  description = "The list of subject claims"
  type        = list(string)
  nullable    = false
}

variable "iam_role_name" {
  description = "The name given to the IAM role which will be created"
  type        = string
}
