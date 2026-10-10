output "client_credentials_id" {
  description = "Map of id values across all client_credentials, keyed the same as var.client_credentials except keys with no id are omitted"
  value       = { for k, v in auth0_client_credentials.client_credentials : k => v.id if v.id != null && length(v.id) > 0 }
}
output "client_credentials_authentication_method" {
  description = "Map of authentication_method values across all client_credentials, keyed the same as var.client_credentials except keys with no authentication_method are omitted"
  value       = { for k, v in auth0_client_credentials.client_credentials : k => v.authentication_method if v.authentication_method != null && length(v.authentication_method) > 0 }
}
output "client_credentials_client_id" {
  description = "Map of client_id values across all client_credentials, keyed the same as var.client_credentials except keys with no client_id are omitted"
  value       = { for k, v in auth0_client_credentials.client_credentials : k => v.client_id if v.client_id != null && length(v.client_id) > 0 }
}
output "client_credentials_client_secret" {
  description = "Map of client_secret values across all client_credentials, keyed the same as var.client_credentials except keys with no client_secret are omitted"
  value       = { for k, v in auth0_client_credentials.client_credentials : k => v.client_secret if v.client_secret != null && length(v.client_secret) > 0 }
  sensitive   = true
}
output "client_credentials_client_secret_wo_version" {
  description = "Map of client_secret_wo_version values across all client_credentials, keyed the same as var.client_credentials except keys with no client_secret_wo_version are omitted"
  value       = { for k, v in auth0_client_credentials.client_credentials : k => v.client_secret_wo_version if v.client_secret_wo_version != null }
}
output "client_credentials_private_key_jwt" {
  description = "Map of private_key_jwt values across all client_credentials, keyed the same as var.client_credentials except keys with no private_key_jwt are omitted"
  value       = { for k, v in auth0_client_credentials.client_credentials : k => one(v.private_key_jwt) if v.private_key_jwt != null && length(v.private_key_jwt) > 0 }
}
output "client_credentials_self_signed_tls_client_auth" {
  description = "Map of self_signed_tls_client_auth values across all client_credentials, keyed the same as var.client_credentials except keys with no self_signed_tls_client_auth are omitted"
  value       = { for k, v in auth0_client_credentials.client_credentials : k => one(v.self_signed_tls_client_auth) if v.self_signed_tls_client_auth != null && length(v.self_signed_tls_client_auth) > 0 }
}
output "client_credentials_signed_request_object" {
  description = "Map of signed_request_object values across all client_credentials, keyed the same as var.client_credentials except keys with no signed_request_object are omitted"
  value       = { for k, v in auth0_client_credentials.client_credentials : k => one(v.signed_request_object) if v.signed_request_object != null && length(v.signed_request_object) > 0 }
}
output "client_credentials_tls_client_auth" {
  description = "Map of tls_client_auth values across all client_credentials, keyed the same as var.client_credentials except keys with no tls_client_auth are omitted"
  value       = { for k, v in auth0_client_credentials.client_credentials : k => one(v.tls_client_auth) if v.tls_client_auth != null && length(v.tls_client_auth) > 0 }
}
output "client_credentials_token_vault_privileged_access" {
  description = "Map of token_vault_privileged_access values across all client_credentials, keyed the same as var.client_credentials except keys with no token_vault_privileged_access are omitted"
  value       = { for k, v in auth0_client_credentials.client_credentials : k => one(v.token_vault_privileged_access) if v.token_vault_privileged_access != null && length(v.token_vault_privileged_access) > 0 }
}

