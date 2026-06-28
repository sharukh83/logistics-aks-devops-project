resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.aks_name
  location            = var.location
  resource_group_name = var.resource_group
  dns_prefix          = "logistics"

  default_node_pool {
    name           = "nodepool1"
    node_count     = var.node_count
    vm_size        = "Standard_B2s"
    vnet_subnet_id = var.subnet_id
  }

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    network_plugin = "azure"
  }

  # 🔥 PRIVATE CLUSTER CONFIG
  private_cluster_enabled = true
}