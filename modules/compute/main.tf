##########################
# Linux Virtual Machine (VM) Resource
##########################

# Define an Azure Linux Virtual Machine with the provided configuration
resource "azurerm_linux_virtual_machine" "chroma_vm" {
  name                = var.chroma_vm_name
  resource_group_name = var.rg_name
  location            = var.location
  size                = var.vm_size
  admin_username      = var.admin_username
  network_interface_ids = [
    var.nic_name1_chroma_id,
  ]

  # Admin SSH key for secure access to the VM
  admin_ssh_key {
    username   = var.admin_username
    public_key = file(var.pathToSSHKey) 
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
}

data "azurerm_image" "custom" {
name                = var.image_name
resource_group_name = var.image_rg_name 
}

resource "azurerm_linux_virtual_machine_scale_set" "vmss" {
  name                = var.vmss_name
  resource_group_name = var.rg_name
  location            = var.location
  sku                 = "Standard_DS1_v2"
  instances           = 2
  admin_username      = "azureuser"
  computer_name_prefix = "chatbotvm"

  source_image_id = data.azurerm_image.custom.id

  disable_password_authentication = true

  admin_ssh_key {
    username   = "azureuser"
    public_key = file(var.pathToSSHKey)
  }

  network_interface {
    name    = "vmss-nic"
    primary = true

    ip_configuration {
      name                                   = "ipconfig1"
      subnet_id                              = var.subnet1_id
      primary = true
      application_gateway_backend_address_pool_ids = [var.appgw_backend_pool_id]
    }
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  identity {
  type = "SystemAssigned"
}

  upgrade_mode = "Automatic"
}
