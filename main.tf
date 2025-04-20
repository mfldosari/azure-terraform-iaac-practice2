##########################
# Resource Group Module
##########################

module "resource_group" {
  source   = "./modules/general/resource_group"
  rg_name  = var.rg_name
  location = var.location
}

##########################
# Network Module
##########################

module "network" {
  source          = "./modules/network"
  rg_name         = var.rg_name
  location        = var.location
  address_space   = var.address_space
  subnet_name     = var.subnet_name
  subnet_prefixe  = var.subnet_prefixe
  nic_name        = var.nic_name
  nsg_name        = var.nsg_name
  vnet_name       = var.vnet_name
}

##########################
# Compute (VM and Function App) Module
##########################

module "compute" {
  source                     = "./modules/compute"
  rg_name                    = var.rg_name
  location                   = var.location
  nic_id                     = module.network.nic_id
  admin_username             = var.admin_username
  vm_size                    = var.vm_size
  vm_name                    = var.vm_name
}