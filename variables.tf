##########################
# Virtual Machine Variables
##########################

# Name of the virtual machine (VM)
variable "vm_name" {
  description = "The name of the virtual machine"
}

# The resource group name in which the VM will reside
variable "rg_name" {
  description = "The name of the resource group for the VM"
}

# The location of the resources (e.g., "East US", "West Europe")
variable "location" {
  description = "The location of the resources"
}

# Size of the virtual machine, e.g., "Standard_DS1_v2"
variable "vm_size" {
  description = "The size of the virtual machine"
}

# The admin username to be used for logging into the virtual machine
variable "admin_username" {
  description = "The admin username for the VM"
}



##########################
# Virtual Network Configuration
##########################

variable "vnet_name" {
  description = "The name of the virtual network"
}

variable "address_space" {
  description = "The address space of the virtual network"
}

##########################
# Subnet Configuration
##########################

variable "subnet_name" {
  description = "The name of the subnet"
}

variable "subnet_prefixe" {
  description = "The subnet address prefix"
}

##########################
# Network Interface and Security Group Configuration
##########################

variable "nic_name" {
  description = "The name of the network interface"
}

variable "nsg_name" {
  description = "The name of the network security group"
}


##########################
# Azure Tenant Information
##########################

variable "tenant_id" {
  description = "Azure Tenant ID"
  type        = string
}

variable "subscription_id" {
  description = "Azure Subscription ID"
  type        = string
}

