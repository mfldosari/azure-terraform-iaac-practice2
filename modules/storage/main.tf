
##########################
# Storage Account Configuration
##########################

# Storage Account Resource
resource "azurerm_storage_account" "this" {
  name                     = var.storage_account_name
  resource_group_name      = var.rg_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    made_by = "terraform"
  }
}

# Storage Container Resource
resource "azurerm_storage_container" "this" {
  name                  = "chatbot"
  storage_account_name  = azurerm_storage_account.this.name
  container_access_type = "private"

  depends_on = [azurerm_storage_account.this]
}


