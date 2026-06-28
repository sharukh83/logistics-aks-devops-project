variable "vnet_name" {}
variable "location" {}
variable "resource_group" {}

variable "address_space" {
  default = ["10.0.0.0/16"]
}

variable "environment" {}