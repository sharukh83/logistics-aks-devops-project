resource "azurerm_resource_group" "rg" {
  name     = "rg-dev"
  location = "East US"
}

module "vnet" {
  source         = "../../modules/vnet"
  vnet_name      = "vnet-dev"
  location       = azurerm_resource_group.rg.location
  resource_group = azurerm_resource_group.rg.name
  environment    = "dev"
}

module "subnets" {
  source         = "../../modules/subnet"
  resource_group = azurerm_resource_group.rg.name
  vnet_name      = module.vnet.vnet_name
  nsg_id         = module.nsg.id   # 🔥 IMPORTANT

  subnets = {
    public = {
      cidr = "10.0.1.0/24"
    }
    private = {
      cidr = "10.0.2.0/24"
    }
  }
}

module "aks" {
  source         = "../../modules/aks"
  aks_name       = "aks-dev"
  resource_group = azurerm_resource_group.rg.name
  location       = azurerm_resource_group.rg.location

  subnet_id  = module.subnets.subnet_ids["private"]
  node_count = 1
}

module "nsg" {
  source         = "../../modules/nsg"
  nsg_name       = "nsg-dev"
  location       = azurerm_resource_group.rg.location
  resource_group = azurerm_resource_group.rg.name
}

module "nat" {
  source         = "../../modules/nat"
  location       = azurerm_resource_group.rg.location
  resource_group = azurerm_resource_group.rg.name
  subnet_id      = module.subnets.subnet_ids["private"]
}