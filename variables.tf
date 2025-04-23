# Resource group name where the VM will be created
variable "rg_name" {
  description = "The name of the resource group"
}

# Azure region where resources will be deployed
variable "location" {
  description = "The location of the resources (e.g., East US)"
}


##########################
# Virtual Machine Configuration
##########################

# Name of the Chroma virtual machine
variable "chroma_vm_name" {
  description = "The name of the Chroma virtual machine"
}


# Size of the virtual machine (SKU)
variable "vm_size" {
  description = "The size of the virtual machine (e.g., Standard_DS1_v2)"
}

# Admin username for logging into the VM
variable "admin_username" {
  description = "The admin username for the virtual machine"
}


##########################
# Virtual Network Configuration
##########################

# Name of the virtual network
variable "vnet_name" {
  description = "The name of the virtual network"
}

# Address space of the virtual network
variable "address_space" {
  description = "The address space of the virtual network"
}


##########################
# Subnet Configuration
##########################

# Name of subnet 1
variable "subnet1_name" {
  description = "The name of subnet 1"
}

# Name of subnet 2
variable "subnet2_name" {
  description = "The name of subnet 2"
}

# Address prefix for subnet 1
variable "subnet1_prefixe" {
  description = "The address prefix for subnet 1"
}

# Address prefix for subnet 2
variable "subnet2_prefixe" {
  description = "The address prefix for subnet 2"
}


##########################
# Network Interface & NSG
##########################

# Network interface name for Chroma VM
variable "nic_name1_chroma_vm" {
  description = "The name of the NIC for Chroma VM"
}

# Network Security Group name for subnet 1
variable "nsg_name_sub1" {
  description = "The NSG name for subnet 1"
}

# Network Security Group name for subnet 2
variable "nsg_name_sub2" {
  description = "The NSG name for subnet 2"
}


##########################
# Azure Subscription Info
##########################

# Azure Tenant ID
variable "tenant_id" {
  description = "Azure Tenant ID"
  type        = string
}

# Azure Subscription ID
variable "subscription_id" {
  description = "Azure Subscription ID"
  type        = string
}


##########################
# Storage Configuration
##########################

# Name of the Azure Storage Account
variable "storage_account_name" {
  description = "The name of the storage account"
  type        = string
}


##########################
# Database Configuration
##########################

# Azure region for database deployment
variable "db_location" {
  description = "The location for the database resources"
}

# Database admin username
variable "db_username" {
  description = "The username for the database"
}

# Database admin password
variable "db_password" {
  description = "The password for the database"
}


##########################
# Azure Key Vault
##########################

# Name of the Key Vault
variable "keyvault_name" {
  description = "The name of the Azure Key Vault"
  type        = string
}

# Object ID of the Azure AD user (yourself)
variable "my_object_id" {
  description = "Azure AD Object ID of the current user"
  type        = string
}


##########################
# Virtual Machine Scale Set
##########################

# Name of the Virtual Machine Scale Set
variable "vmss_name" {
  description = "The name of the VMSS"
  type        = string
}

# Name of the custom image to use
variable "image_name" {
  description = "The name of the custom image"
  type        = string
}

# Resource group containing the custom image
variable "image_rg_name" {
  description = "The resource group of the custom image"
  type        = string
}

# Path to the public SSH key
variable "pathToSSHKey" {
  description = "Path to the public SSH key to use for authentication"
  type        = string
}
