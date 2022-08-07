terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}

# Create resource group
resource "azurerm_resource_group" "rg" {
  name     = var.RESOURCE_GROUP_NAME
  location = var.RESOURCE_GROUP_LOCATION
  tags     = var.RESOURCE_TAGS
}

# Create virtual network
resource "azurerm_virtual_network" "vnet" {
  name                = var.VIRTUAL_NETWORK_NAME
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = var.VIRTUAL_NETWORK_PREFIXES
  dns_servers         = var.VIRTUAL_NETWORK_DNS

  tags = var.RESOURCE_TAGS

  depends_on = [
    azurerm_resource_group.rg
  ]
}

# Create subnet(s)
resource "azurerm_subnet" "snet" {
  for_each = var.VIRTUAL_NETWORK_SUBNETS

  name                 = each.value["name"]
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [each.value["address_prefixes"]]

  depends_on = [
    azurerm_virtual_network.vnet
  ]
}

# Create route table(s)
resource "azurerm_route_table" "rt" {
  for_each = var.VIRTUAL_NETWORK_SUBNETS

  name                          = "${var.VIRTUAL_NETWORK_NAME}${each.value["name"]}RT"
  location                      = azurerm_resource_group.rg.location
  resource_group_name           = azurerm_resource_group.rg.name
  disable_bgp_route_propagation = true

  route = var.ROUTE_TABLE_RULES

  tags = var.RESOURCE_TAGS

  depends_on = [
    azurerm_subnet.snet
  ]
}

# Associate the route table to the subnet
resource "azurerm_subnet_route_table_association" "snet_rt_asc" {
  for_each = var.VIRTUAL_NETWORK_SUBNETS

  # Both subnet and route table map are created using the same variable
  # which means they contain the map object same keys
  subnet_id      = azurerm_subnet.snet[each.key].id
  route_table_id = azurerm_route_table.rt[each.key].id

  depends_on = [
    azurerm_subnet.snet,
    azurerm_route_table.rt,
  ]
}
