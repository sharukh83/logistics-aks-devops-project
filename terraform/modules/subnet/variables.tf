

variable "resource_group" {}
variable "vnet_name" {}

variable "subnets" {
  type = map(object({
    cidr = string
  }))
}

variable "nsg_id" {}