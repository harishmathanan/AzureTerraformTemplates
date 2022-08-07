variable "RESOURCE_GROUP_NAME" {
  type = string
}

variable "RESOURCE_GROUP_LOCATION" {
  type = string
}

variable "RESOURCE_TAGS" {
  type = map(string)
}

variable "VIRTUAL_NETWORK_NAME" {
  type = string
}

variable "VIRTUAL_NETWORK_PREFIXES" {
  type = list(string)
}

variable "VIRTUAL_NETWORK_DNS" {
  type = list(string)
}

variable "VIRTUAL_NETWORK_SUBNETS" {
  type = map(any)
}

variable "ROUTE_TABLE_RULES" {
  type = list(any)
}
