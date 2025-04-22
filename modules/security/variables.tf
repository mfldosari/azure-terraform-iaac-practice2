##########################
# Variable Definitions
##########################

# Variable for Azure Key Vault Name
variable "keyvault_name" {
  description = "The name of the Azure Key Vault"
  type        = string
}

# Variable for Resource Group Name
variable "rg_name" {
  description = "The resource group name"
  type        = string
}

# Variable for Azure Location
variable "location" {
  description = "The Azure location for resources"
  type        = string
}

# Variable for Azure Tenant ID
variable "tenant_id" {
  description = "Azure Tenant ID"
  type        = string
}

# Variable for object id for IAM access to Key Vault
variable "my_object_id" {
  description = "Azure AD Object ID of the user (yourself)"
  type        = string
}

# Variable for principal_id of vmss for IAM access to Key Vault
variable "vmss_principal_id" {
  type        = string
  description = "The principal ID of the VMSS managed identity"
}