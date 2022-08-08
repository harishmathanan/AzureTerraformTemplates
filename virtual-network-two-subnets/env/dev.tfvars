RESOURCE_GROUP_NAME     = "<Resource Group Name>"
RESOURCE_GROUP_LOCATION = "<Azure Region for Deployment>"
RESOURCE_TAGS = {
  "<Key>"       = "<Value>"
  "Owner"       = "user@demo.com"
  "Environment" = "Development"
}

VIRTUAL_NETWORK_NAME     = "<Virtual Network Name>"
VIRTUAL_NETWORK_PREFIXES = ["<Virtual Network Prefixes> 10.0.0.0/22"]
VIRTUAL_NETWORK_DNS      = ["<Virtual Network DNS Servers>"]

VIRTUAL_NETWORK_SUBNETS = {
  "SubnetA" = {
    name             = "SubnetA"
    address_prefixes = "10.0.0.0/24"
  },
  "SubnetB" = {
    name             = "SubnetB"
    address_prefixes = "10.0.1.0/24"
  }
}

# Route tables rules, example routes traffic through a mock NVA
ROUTE_TABLE_RULES = [
  {
    name                   = "RouteRule1"
    address_prefix         = "192.168.7.0/22"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.0.0.9"
  },
  {
    name                   = "RouteRule2"
    address_prefix         = "0.0.0.0/0"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.0.0.9"
  }
]
