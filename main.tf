##########################
# Resource Group Module
##########################

module "resource_group" {
  source   = "./modules/general/resource_group"
  rg_name  = var.rg_name
  location = var.location
}

##########################
# Database Module
##########################

module "database" {
  source      = "./modules/database"
  rg_name     = var.rg_name
  db_location = var.db_location
  db_username = var.db_username
  db_password = var.db_password
}

##########################
# Storage Module
##########################

module "storage" {
  source               = "./modules/storage"
  rg_name              = var.rg_name
  location             = var.location
  storage_account_name = var.storage_account_name
}



##########################
# Network Module
##########################

module "network" {
  source              = "./modules/network"
  rg_name             = var.rg_name
  location            = var.location
  address_space       = var.address_space
  subnet1_name        = var.subnet1_name
  subnet2_name        = var.subnet2_name
  subnet1_prefixe     = var.subnet1_prefixe
  subnet2_prefixe     = var.subnet2_prefixe
  nic_name1_chroma_vm = var.nic_name1_chroma_vm
  nsg_name_sub1       = var.nsg_name_sub1
  nsg_name_sub2       = var.nsg_name_sub2
  vnet_name           = var.vnet_name
}



##########################
# Compute (VM and Function App) Module
##########################

module "compute" {
  source                    = "./modules/compute"
  rg_name                   = var.rg_name
  location                  = var.location
  nic_name1_chroma_id       = module.network.nic_name1_chroma_id
  admin_username            = var.admin_username
  vm_size                   = var.vm_size
  chroma_vm_name            = var.chroma_vm_name
  subnet1_id                = module.network.subnetid1
  appgw_backend_pool_id     = module.network.appgw_backend_pool_id
  vmss_name                 = var.vmss_name
  image_name                = var.image_name
  image_rg_name             = var.image_rg_name
  pathToSSHKey              = var.pathToSSHKey
}




##########################
# Security (Key Vault) Module
##########################

module "security" {
  source            = "./modules/security"
  keyvault_name     = var.keyvault_name
  location          = var.location
  rg_name           = var.rg_name
  tenant_id         = var.tenant_id
  my_object_id      = var.my_object_id
  vmss_principal_id = module.compute.vmss_principal_id
}
