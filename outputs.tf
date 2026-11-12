output "client_credentials_id" {
  description = "Map of id values across all client_credentials, keyed the same as var.client_credentials"
  value       = { for k, v in auth0_client_credentials.client_credentials : k => v.id }
}
output "client_credentials_authentication_method" {
  description = "Map of authentication_method values across all client_credentials, keyed the same as var.client_credentials"
  value       = { for k, v in auth0_client_credentials.client_credentials : k => v.authentication_method }
}
output "client_credentials_client_id" {
  description = "Map of client_id values across all client_credentials, keyed the same as var.client_credentials"
  value       = { for k, v in auth0_client_credentials.client_credentials : k => v.client_id }
}
output "client_credentials_client_secret" {
  description = "Map of client_secret values across all client_credentials, keyed the same as var.client_credentials"
  value       = { for k, v in auth0_client_credentials.client_credentials : k => v.client_secret }
  sensitive   = true
}
output "client_credentials_client_secret_wo_version" {
  description = "Map of client_secret_wo_version values across all client_credentials, keyed the same as var.client_credentials"
  value       = { for k, v in auth0_client_credentials.client_credentials : k => v.client_secret_wo_version }
}
output "client_credentials_private_key_jwt" {
  description = "Map of private_key_jwt values across all client_credentials, keyed the same as var.client_credentials"
  value       = { for k, v in auth0_client_credentials.client_credentials : k => one(v.private_key_jwt) }
}
output "client_credentials_self_signed_tls_client_auth" {
  description = "Map of self_signed_tls_client_auth values across all client_credentials, keyed the same as var.client_credentials"
  value       = { for k, v in auth0_client_credentials.client_credentials : k => one(v.self_signed_tls_client_auth) }
}
output "client_credentials_signed_request_object" {
  description = "Map of signed_request_object values across all client_credentials, keyed the same as var.client_credentials"
  value       = { for k, v in auth0_client_credentials.client_credentials : k => one(v.signed_request_object) }
}
output "client_credentials_tls_client_auth" {
  description = "Map of tls_client_auth values across all client_credentials, keyed the same as var.client_credentials"
  value       = { for k, v in auth0_client_credentials.client_credentials : k => one(v.tls_client_auth) }
}
output "client_credentials_token_vault_privileged_access" {
  description = "Map of token_vault_privileged_access values across all client_credentials, keyed the same as var.client_credentials"
  value       = { for k, v in auth0_client_credentials.client_credentials : k => one(v.token_vault_privileged_access) }
}

