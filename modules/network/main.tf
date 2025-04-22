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
# Subnets Creation
##########################

# Creates a subnet within the virtual network
resource "azurerm_subnet" "sub1" {
  name                 = var.subnet1_name
  resource_group_name  = var.rg_name
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes     = var.subnet1_prefixe
}

# Creates a subnet within the virtual network
resource "azurerm_subnet" "sub2" {
  name                 = var.subnet2_name
  resource_group_name  = var.rg_name
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes     = var.subnet2_prefixe
}

##########################
# Network Security Group Creation
##########################

# Creates a network security group for sub 1 with an SSH rule allowing inbound traffic on port 22
resource "azurerm_network_security_group" "nsg1" {
  name                = var.nsg_name_sub1
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
   # Security rule to allow SSH on port 22
  security_rule {
    name                       = "Allow-streamlit"
    priority                   = 900
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                  = "Tcp"
    source_port_range         = "*"
    destination_port_range    = "8501"
    source_address_prefix     = "*"
    destination_address_prefix = "*"
    description               = "Allow SSH traffic on port 22"
  }

   # Security rule to allow SSH on port 22
  security_rule {
    name                       = "Allow-fastapi"
    priority                   = 800
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                  = "Tcp"
    source_port_range         = "*"
    destination_port_range    = "5000"
    source_address_prefix     = "*"
    destination_address_prefix = "*"
    description               = ""
  }
   # Security rule to allow SSH on port 22
  security_rule {
    name                       = "Allow-chroma"
    priority                   = 700
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                  = "Tcp"
    source_port_range         = "*"
    destination_port_range    = "8000"
    source_address_prefix     = "*"
    destination_address_prefix = "*"
    description               = ""
  }
}

# Creates a network security group for sub 2 with an SSH rule allowing inbound traffic on port 22
resource "azurerm_network_security_group" "nsg2" {
  name                = var.nsg_name_sub2
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
resource "azurerm_public_ip" "chroma_vm" {
  name                = "chroma-ip"
  resource_group_name = var.rg_name
  location            = var.location
  allocation_method   = "Static"
}

# Creates a static public IP address for use with a network interface
resource "azurerm_public_ip" "streamlit_uvicorn_vm" {
  name                = "streamlit-ip"
  resource_group_name = var.rg_name
  location            = var.location
  allocation_method   = "Static"
}

##########################
# Network Interface Creation
##########################

# Creates a network interface and assigns a dynamic private IP with a public IP
resource "azurerm_network_interface" "nic1-chroma" {
  name                = var.nic_name1_chroma_vm
  location            = var.location
  resource_group_name = var.rg_name

  # Configuration for IP address allocation and association with a public IP
  ip_configuration {
    name                          = "ip_address_chroma"
    subnet_id                     = azurerm_subnet.sub1.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.chroma_vm.id
  }
}


##########################
# Network Interface Security Group Association and Application Gateway
##########################

# Associates the network interface with a network security group for security rules enforcement (Chroma vm)
resource "azurerm_network_interface_security_group_association" "linktoChromavm" {
  network_interface_id      = azurerm_network_interface.nic1-chroma.id
  network_security_group_id = azurerm_network_security_group.nsg1.id
}



resource "azurerm_application_gateway" "appgw" {
  name                = "chatbot-appgw"
  resource_group_name = var.rg_name
  location            = var.location
  sku {
    name     = "Standard_v2"
    tier     = "Standard_v2"
    capacity = 2
  }

  gateway_ip_configuration {
    name      = "appgw-ip-config"
    subnet_id = azurerm_subnet.sub2.id
  }

  frontend_ip_configuration {
    name                 = "appgw-frontend-ip"
    public_ip_address_id = azurerm_public_ip.streamlit_uvicorn_vm.id
  }

  frontend_port {
    name = "http"
    port = 80
  }

  backend_address_pool {
    name = "vmss-backend-pool"
    # no addresses - backend is linked by VMSS backend pool ID
  }

  backend_http_settings {
    name                  = "http-settings"
    port                  = 8501
    protocol              = "Http"
    cookie_based_affinity = "Disabled"
    request_timeout       = 20
  }

  http_listener {
    name                           = "listener"
    frontend_ip_configuration_name = "appgw-frontend-ip"
    frontend_port_name             = "http"
    protocol                       = "Http"
  }

  request_routing_rule {
    name                       = "rule1"
    rule_type                  = "Basic"
    http_listener_name         = "listener"
    backend_address_pool_name  = "vmss-backend-pool"
    backend_http_settings_name = "http-settings"
    priority                   = 100  

  }
}
