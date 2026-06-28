resource "azurerm_resource_group" "rg" {
  name     = "rg-logistics-prod"
  location = "East US"
}

module "acr" {
  source         = "../../modules/acr"
  acr_name       = "acrprod12345"
  resource_group = azurerm_resource_group.rg.name
  location       = azurerm_resource_group.rg.location
}

module "aks" {
  source         = "../../modules/aks"
  aks_name       = "aks-prod"
  resource_group = azurerm_resource_group.rg.name
  location       = azurerm_resource_group.rg.location
  node_count     = 2
}

module "keyvault" {
  source         = "../../modules/keyvault"
  kv_name        = "kv-prod-12345"
  resource_group = azurerm_resource_group.rg.name
  location       = azurerm_resource_group.rg.location
}