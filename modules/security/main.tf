##########################
# Key Vault Resource
##########################

resource "azurerm_key_vault" "kv" {
  # Basic Information
  name                        = var.keyvault_name
  location                    = var.location
  resource_group_name         = var.rg_name
  tenant_id                   = var.tenant_id
  
  # SKU and Access Configuration
  sku_name                    = "standard"
  enable_rbac_authorization   = true

  # Soft Delete and Purge Protection
  soft_delete_retention_days  = 90
  purge_protection_enabled    = true
  
  # Network Access Configuration
  public_network_access_enabled = true  

  # Tags
  tags = {
    managed_by = "terraform"
  }
}



##########################
# IAM Role Assignment (Self) and (VMSS)
##########################

resource "azurerm_role_assignment" "kv_admin" {
  principal_id         = var.my_object_id
  role_definition_name = "Key Vault Administrator"
  scope                = azurerm_key_vault.kv.id
}

# Role assignment to allow VM to access secrets in the Key Vault
resource "azurerm_role_assignment" "vmss_kv_access" {
  principal_id         = var.vmss_principal_id  
  role_definition_name = "Key Vault Secrets User"  
  scope                = azurerm_key_vault.kv.id  
}