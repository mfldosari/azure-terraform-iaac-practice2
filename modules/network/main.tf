##########################
# Virtual Network Creation
##########################

# Creates a virtual network in the specified resource group and location
resource "azurerm_virtual_network" "this" {
  name                = var.vnet_name
  address_space       = var.address_space
  location            = var.location
  resource_group_name = var.rg_name
}

##########################
# Subnet Creation
##########################

# Creates a subnet within the virtual network
resource "azurerm_subnet" "this" {
  name                 = var.subnet_name
  resource_group_name  = var.rg_name
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes     = var.subnet_prefixe
}

##########################
# Network Security Group Creation
##########################

# Creates a network security group with an SSH rule allowing inbound traffic on port 22
resource "azurerm_network_security_group" "this" {
  name                = var.nsg_name
  location            = var.location
  resource_group_name = var.rg_name

  # Security rule to allow SSH on port 22
  security_rule {
    name                       = "Allow-SSH"
    priority                   = 1000
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                  = "Tcp"
    source_port_range         = "*"
    destination_port_range    = "22"
    source_address_prefix     = "*"
    destination_address_prefix = "*"
    description               = "Allow SSH traffic on port 22"
  }
}

##########################
# Public IP Address Creation
##########################

# Creates a static public IP address for use with a network interface
resource "azurerm_public_ip" "this" {
  name                = "acceptanceTestPublicIp1"
  resource_group_name = var.rg_name
  location            = var.location
  allocation_method   = "Static"
}

##########################
# Network Interface Creation
##########################

# Creates a network interface and assigns a dynamic private IP with a public IP
resource "azurerm_network_interface" "this" {
  name                = var.nic_name
  location            = var.location
  resource_group_name = var.rg_name

  # Configuration for IP address allocation and association with a public IP
  ip_configuration {
    name                          = "ip_address_1"
    subnet_id                     = azurerm_subnet.this.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.this.id
  }
}

##########################
# Network Interface Security Group Association
##########################

# Associates the network interface with a network security group for security rules enforcement
resource "azurerm_network_interface_security_group_association" "this" {
  network_interface_id      = azurerm_network_interface.this.id
  network_security_group_id = azurerm_network_security_group.this.id
}