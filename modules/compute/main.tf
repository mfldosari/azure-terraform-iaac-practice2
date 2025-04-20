##########################
# Linux Virtual Machine (VM) Resource
##########################

# Define an Azure Linux Virtual Machine with the provided configuration
resource "azurerm_linux_virtual_machine" "this" {
  name                = var.vm_name
  resource_group_name = var.rg_name
  location            = var.location
  size                = var.vm_size
  admin_username      = var.admin_username
  network_interface_ids = [
    var.nic_id,
  ]

  # Admin SSH key for secure access to the VM
  admin_ssh_key {
    username   = var.admin_username
    public_key = file("~/.ssh/id_rsa.pub") 
  }

  # OS disk configuration (Standard_LRS for redundant storage)
  os_disk {
    caching              = "ReadWrite" 
    storage_account_type = "Standard_LRS"  
  }

  # Source image configuration (Ubuntu 22.04 LTS)
  source_image_reference {
    publisher = "Canonical"  
    offer     = "0001-com-ubuntu-server-jammy" 
    sku       = "22_04-lts" 
    version   = "latest"  
  }

  # Enable managed identity for the VM
 /*  identity {
    type = "SystemAssigned"  
  } */
}
