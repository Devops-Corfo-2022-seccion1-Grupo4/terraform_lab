# Generate random resource group name
resource "random_pet" "rg_name" {
  prefix = var.resource_group_name_prefix
}

resource "azurerm_resource_group" "rg" {
  location = var.resource_group_location
  name     = random_pet.rg_name.id

  tags = {
    "Group" = var.group
  }
}

resource "azurerm_virtual_network" "k8s-net" {
  name = "k8sclusternet"
  address_space = [ "12.0.0.0/16" ]
  location = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  
}

resource "azurerm_subnet" "k8s-subnet" {
  name = "internal"
  resource_group_name = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.k8s-net.name
  address_prefixes = [ "12.0.0.0/20" ]
  
}

resource "azurerm_container_registry" "acr-k8s-dev" {
  name = "acrk8sgroup4"
  resource_group_name = azurerm_resource_group.rg.name
  location = azurerm_resource_group.rg.location
  sku = "Basic"
  admin_enabled = true
  
}

resource "azurerm_kubernetes_cluster" "k8s-dev-cluster" {
  kubernetes_version  = var.k8s_version
  location            = azurerm_resource_group.rg.location
  name                = var.cluster_name
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = var.dns_prefix
  tags                = {
    Environment = "Development"
  }

  default_node_pool {
    name       = "agentpool"
    vm_size    = "Standard_D2_v2"
    node_count = var.agent_count
    max_count  = var.max_count
    min_count  = var.min_count
    vnet_subnet_id = azurerm_subnet.k8s-subnet.id
    enable_auto_scaling = true
    max_pods = var.max_pods
  }


  linux_profile {
    admin_username = "ubuntu"

    ssh_key {
      key_data = file(var.ssh_public_key)
    }
  }

  network_profile {
    network_plugin    = "azure"
    load_balancer_sku = "standard"
    network_policy    = "azure"
  }
  service_principal {
    client_id     = var.aks_service_principal_client_id
    client_secret = var.aks_service_principal_client_secret
  }

  role_based_access_control_enabled = true

}

resource "azurerm_kubernetes_cluster_node_pool" "adicional" {
  name                  = "adicional"
  kubernetes_cluster_id = azurerm_kubernetes_cluster.k8s-dev-cluster.id
  vm_size               = "Standard_DS2_v2"
  node_count            = 1

  tags = {
    label = "adicional"
  }
}


