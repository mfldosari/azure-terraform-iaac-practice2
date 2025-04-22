##########################
# General Configuration
##########################

rg_name  = "" # Name of the resource group
location = "" # Azure region (e.g., East US, Canada Central)


##########################
# Virtual Network & Subnets
##########################

vnet_name    = "" # Name of the virtual network
subnet1_name = "" # Name of subnet 1 (used for VMs)
subnet2_name = "" # Name of subnet 2 (used for App Gateway)

address_space   = [""] # CIDR block for the virtual network
subnet1_prefixe = [""] # CIDR block for subnet 1
subnet2_prefixe = [""] # CIDR block for subnet 2


##########################
# Network Security Groups & NICs
##########################

nsg_name_sub1 = "" # NSG for subnet 1 (VMs)
nsg_name_sub2 = "" # NSG for subnet 2 (App Gateway)

nic_name1_chroma_vm = "" # Network Interface for Chroma VM


##########################
# Virtual Machines
##########################

chroma_vm_name            = "" # Name of the Chroma VM
streamlit_uvicorn_vm_name = "" # Name of the Streamlit Uvicorn VM

vm_size        = "" # VM size
admin_username = "" # Admin username for VMs


##########################
# Azure Identity
##########################

subscription_id = "" # Azure Subscription ID
tenant_id       = "" # Azure Tenant ID


##########################
# Storage
##########################

storage_account_name = "" # Azure Storage Account name


##########################
# Database Configuration
##########################

db_location = "" # Location for DB resources
db_username = "" # Database username
db_password = "" # Database password (sensitive)


##########################
# Key Vault
##########################

keyvault_name = "" # Name of the Azure Key Vault
my_object_id  = "" # Your Azure AD object ID


##########################
# VM Scale Set
##########################

vmss_name     = "" # Name of the VM Scale Set
image_name    = "" # Name of the custom image
image_rg_name = "" # Resource group containing the custom image


##########################
# SSH Key
##########################

pathToSSHKey = "" # Path to public SSH key
