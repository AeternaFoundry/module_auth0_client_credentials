variable "client_credentials" {
  description = <<EOT
Map of client_credentials, attributes below
Required:
    - client_id
Optional:
    - authentication_method
    - client_secret
    - client_secret_wo
    - client_secret_wo_version
    - private_key_jwt (block):
        - credentials (required, block):
            - algorithm (optional)
            - credential_type (required)
            - expires_at (optional)
            - name (optional)
            - parse_expiry_from_cert (optional)
            - pem (required)
    - self_signed_tls_client_auth (block):
        - credentials (required, block):
            - credential_type (optional)
            - name (optional)
            - pem (required)
    - signed_request_object (block):
        - credentials (required, block):
            - algorithm (optional)
            - credential_type (required)
            - expires_at (optional)
            - name (optional)
            - parse_expiry_from_cert (optional)
            - pem (required)
        - required (optional)
    - tls_client_auth (block):
        - credentials (required, block):
            - credential_type (required)
            - name (optional)
            - pem (optional)
            - subject_dn (optional)
    - token_vault_privileged_access (block):
        - credentials (required, block):
            - algorithm (optional)
            - credential_type (required)
            - expires_at (optional)
            - name (optional)
            - parse_expiry_from_cert (optional)
            - pem (required)
        - grants (optional, block):
            - connection (required)
            - scopes (required)
        - ip_allowlist (required)
EOT

  type = map(object({
    client_id                = string
    authentication_method    = optional(string)
    client_secret            = optional(string)
    client_secret_wo         = optional(string)
    client_secret_wo_version = optional(number)
    private_key_jwt = optional(object({
      credentials = list(object({
        algorithm              = optional(string)
        credential_type        = string
        expires_at             = optional(string)
        name                   = optional(string)
        parse_expiry_from_cert = optional(bool)
        pem                    = string
      }))
    }))
    self_signed_tls_client_auth = optional(object({
      credentials = list(object({
        credential_type = optional(string)
        name            = optional(string)
        pem             = string
      }))
    }))
    signed_request_object = optional(object({
      credentials = list(object({
        algorithm              = optional(string)
        credential_type        = string
        expires_at             = optional(string)
        name                   = optional(string)
        parse_expiry_from_cert = optional(bool)
        pem                    = string
      }))
      required = optional(bool)
    }))
    tls_client_auth = optional(object({
      credentials = list(object({
        credential_type = string
        name            = optional(string)
        pem             = optional(string)
        subject_dn      = optional(string)
      }))
    }))
    token_vault_privileged_access = optional(object({
      credentials = list(object({
        algorithm              = optional(string)
        credential_type        = string
        expires_at             = optional(string)
        name                   = optional(string)
        parse_expiry_from_cert = optional(bool)
        pem                    = string
      }))
      grants = optional(list(object({
        connection = string
        scopes     = set(string)
      })))
      ip_allowlist = set(string)
    }))
  }))
  validation {
    condition = alltrue([
      for k, v in var.client_credentials : (
        v.private_key_jwt == null || (length(v.private_key_jwt.credentials) >= 1 && length(v.private_key_jwt.credentials) <= 2)
      )
    ])
    error_message = "Each credentials list must contain between 1 and 2 items"
  }
  validation {
    condition = alltrue([
      for k, v in var.client_credentials : (
        v.self_signed_tls_client_auth == null || (length(v.self_signed_tls_client_auth.credentials) >= 1)
      )
    ])
    error_message = "Each credentials list must contain at least 1 items"
  }
  validation {
    condition = alltrue([
      for k, v in var.client_credentials : (
        v.signed_request_object == null || (length(v.signed_request_object.credentials) >= 1)
      )
    ])
    error_message = "Each credentials list must contain at least 1 items"
  }
  validation {
    condition = alltrue([
      for k, v in var.client_credentials : (
        v.tls_client_auth == null || (length(v.tls_client_auth.credentials) >= 1)
      )
    ])
    error_message = "Each credentials list must contain at least 1 items"
  }
  validation {
    condition = alltrue([
      for k, v in var.client_credentials : (
        v.token_vault_privileged_access == null || (length(v.token_vault_privileged_access.credentials) >= 1 && length(v.token_vault_privileged_access.credentials) <= 2)
      )
    ])
    error_message = "Each credentials list must contain between 1 and 2 items"
  }
  validation {
    condition = alltrue([
      for k, v in var.client_credentials : (
        v.token_vault_privileged_access == null || (v.token_vault_privileged_access.grants == null || (length(v.token_vault_privileged_access.grants) <= 5))
      )
    ])
    error_message = "Each grants list must contain at most 5 items"
  }
  validation {
    condition = alltrue([
      for k, v in var.client_credentials : (
        v.authentication_method == null || (contains(["none", "client_secret_post", "client_secret_basic", "private_key_jwt", "tls_client_auth", "self_signed_tls_client_auth"], v.authentication_method))
      )
    ])
    error_message = "must be one of: \"none\", \"client_secret_post\", \"client_secret_basic\", \"private_key_jwt\", \"tls_client_auth\", \"self_signed_tls_client_auth\""
  }
  validation {
    condition = alltrue([
      for k, v in var.client_credentials : (
        v.client_secret_wo_version == null || (v.client_secret_wo_version >= 1)
      )
    ])
    error_message = "must be at least 1"
  }
  validation {
    condition = alltrue([
      for k, v in var.client_credentials : (
        v.private_key_jwt == null || (alltrue([for item in v.private_key_jwt.credentials : (contains(["public_key"], item.credential_type))]))
      )
    ])
    error_message = "must be one of: \"public_key\""
  }
  validation {
    condition = alltrue([
      for k, v in var.client_credentials : (
        v.private_key_jwt == null || (alltrue([for item in v.private_key_jwt.credentials : (item.algorithm == null || (contains(["RS256", "RS384", "PS256"], item.algorithm)))]))
      )
    ])
    error_message = "must be one of: \"RS256\", \"RS384\", \"PS256\""
  }
  validation {
    condition = alltrue([
      for k, v in var.client_credentials : (
        v.tls_client_auth == null || (alltrue([for item in v.tls_client_auth.credentials : (contains(["cert_subject_dn"], item.credential_type))]))
      )
    ])
    error_message = "must be one of: \"cert_subject_dn\""
  }
  validation {
    condition = alltrue([
      for k, v in var.client_credentials : (
        v.tls_client_auth == null || (alltrue([for item in v.tls_client_auth.credentials : (item.subject_dn == null || (length(item.subject_dn) >= 1 && length(item.subject_dn) <= 256))]))
      )
    ])
    error_message = "must be between 1 and 256 characters"
  }
  validation {
    condition = alltrue([
      for k, v in var.client_credentials : (
        v.tls_client_auth == null || (alltrue([for item in v.tls_client_auth.credentials : (item.pem == null || (length(item.pem) >= 1 && length(item.pem) <= 4096))]))
      )
    ])
    error_message = "must be between 1 and 4096 characters"
  }
  validation {
    condition = alltrue([
      for k, v in var.client_credentials : (
        v.self_signed_tls_client_auth == null || (alltrue([for item in v.self_signed_tls_client_auth.credentials : (item.credential_type == null || (contains(["x509_cert"], item.credential_type)))]))
      )
    ])
    error_message = "must be one of: \"x509_cert\""
  }
  validation {
    condition = alltrue([
      for k, v in var.client_credentials : (
        v.self_signed_tls_client_auth == null || (alltrue([for item in v.self_signed_tls_client_auth.credentials : (length(item.pem) >= 1 && length(item.pem) <= 4096)]))
      )
    ])
    error_message = "must be between 1 and 4096 characters"
  }
  validation {
    condition = alltrue([
      for k, v in var.client_credentials : (
        v.signed_request_object == null || (alltrue([for item in v.signed_request_object.credentials : (contains(["public_key"], item.credential_type))]))
      )
    ])
    error_message = "must be one of: \"public_key\""
  }
  validation {
    condition = alltrue([
      for k, v in var.client_credentials : (
        v.signed_request_object == null || (alltrue([for item in v.signed_request_object.credentials : (item.algorithm == null || (contains(["RS256", "RS384", "PS256"], item.algorithm)))]))
      )
    ])
    error_message = "must be one of: \"RS256\", \"RS384\", \"PS256\""
  }
  validation {
    condition = alltrue([
      for k, v in var.client_credentials : (
        v.token_vault_privileged_access == null || (alltrue([for item in v.token_vault_privileged_access.credentials : (contains(["public_key"], item.credential_type))]))
      )
    ])
    error_message = "must be one of: \"public_key\""
  }
  validation {
    condition = alltrue([
      for k, v in var.client_credentials : (
        v.token_vault_privileged_access == null || (alltrue([for item in v.token_vault_privileged_access.credentials : (item.algorithm == null || (contains(["RS256", "RS384", "PS256"], item.algorithm)))]))
      )
    ])
    error_message = "must be one of: \"RS256\", \"RS384\", \"PS256\""
  }
  # Note: 4 additional provider-side validators are enforced at apply time but not mirrored as validation{} blocks here (bespoke or non-mechanically-translatable).
}

