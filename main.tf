resource "auth0_client_credentials" "client_credentials" {
  for_each = var.client_credentials

  client_id                = each.value.client_id
  authentication_method    = each.value.authentication_method
  client_secret            = each.value.client_secret
  client_secret_wo         = each.value.client_secret_wo
  client_secret_wo_version = each.value.client_secret_wo_version

  dynamic "private_key_jwt" {
    for_each = each.value.private_key_jwt != null ? [each.value.private_key_jwt] : []
    content {
      dynamic "credentials" {
        for_each = private_key_jwt.value.credentials
        content {
          algorithm              = credentials.value.algorithm
          credential_type        = credentials.value.credential_type
          expires_at             = credentials.value.expires_at
          name                   = credentials.value.name
          parse_expiry_from_cert = credentials.value.parse_expiry_from_cert
          pem                    = credentials.value.pem
        }
      }
    }
  }

  dynamic "self_signed_tls_client_auth" {
    for_each = each.value.self_signed_tls_client_auth != null ? [each.value.self_signed_tls_client_auth] : []
    content {
      dynamic "credentials" {
        for_each = self_signed_tls_client_auth.value.credentials
        content {
          credential_type = credentials.value.credential_type
          name            = credentials.value.name
          pem             = credentials.value.pem
        }
      }
    }
  }

  dynamic "signed_request_object" {
    for_each = each.value.signed_request_object != null ? [each.value.signed_request_object] : []
    content {
      dynamic "credentials" {
        for_each = signed_request_object.value.credentials
        content {
          algorithm              = credentials.value.algorithm
          credential_type        = credentials.value.credential_type
          expires_at             = credentials.value.expires_at
          name                   = credentials.value.name
          parse_expiry_from_cert = credentials.value.parse_expiry_from_cert
          pem                    = credentials.value.pem
        }
      }
      required = signed_request_object.value.required
    }
  }

  dynamic "tls_client_auth" {
    for_each = each.value.tls_client_auth != null ? [each.value.tls_client_auth] : []
    content {
      dynamic "credentials" {
        for_each = tls_client_auth.value.credentials
        content {
          credential_type = credentials.value.credential_type
          name            = credentials.value.name
          pem             = credentials.value.pem
          subject_dn      = credentials.value.subject_dn
        }
      }
    }
  }

  dynamic "token_vault_privileged_access" {
    for_each = each.value.token_vault_privileged_access != null ? [each.value.token_vault_privileged_access] : []
    content {
      dynamic "credentials" {
        for_each = token_vault_privileged_access.value.credentials
        content {
          algorithm              = credentials.value.algorithm
          credential_type        = credentials.value.credential_type
          expires_at             = credentials.value.expires_at
          name                   = credentials.value.name
          parse_expiry_from_cert = credentials.value.parse_expiry_from_cert
          pem                    = credentials.value.pem
        }
      }
      dynamic "grants" {
        for_each = token_vault_privileged_access.value.grants != null ? token_vault_privileged_access.value.grants : []
        content {
          connection = grants.value.connection
          scopes     = grants.value.scopes
        }
      }
      ip_allowlist = token_vault_privileged_access.value.ip_allowlist
    }
  }
}

