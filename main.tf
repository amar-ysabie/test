terraform {
  required_providers {
    fortios = {
      source = "fortinetdev/fortios"
      version = "1.16.0"
    }
    netbox = {
      source  = "e-breuninger/netbox"
      #version = "~> 3.2.1"
      version = "~> 3.7.7"
    }
    http = {
      source = "hashicorp/http"
      version = "3.4.1"
    }
  }
}

provider "fortios" {
  hostname = "192.168.51.29"
  token = "QxkgtHNkkQ8fzq0dqbpHNk6y1Hsrxp"
  insecure = "true"
  
}

provider "netbox" {
  server_url = "http://10.221.185.35:8000"
  api_token  = "865a8e836cbf95b9bc1ea656b68d34d4597a6a51"
}

data "http" "networks" {
  url  = "http://10.221.185.28:8000/v1/network/"
  method = "GET"
}


# locals {
#   network_data = jsondecode(data.http.networks.body)
#   network2_data = jsondecode(data.http.networks2.body)
# }

# locals {
#   filtered_data = [for network in jsondecode(data.http.networks.body) : {
#     name = network.name
#     url  = "${network.url}ipranges/"
#   }]
# }

# locals {
#   final_data = [for network in local.filtered_data : {
#     name     = network.name
#     url      = network.url
#     iprange  = jsondecode(data.http.iprange_data[network.url].body).iprange
#   }]
# }

# data "http" "iprange_data" {
#   for_each = { for network in local.filtered_data : network.url => {} }
#   url      = each.key
# }


# output "filtered_urls" {
#   value = local.filtered_data
# }

# output network {
#     value = local.all_name
# }

# output test {
#     value = local.all_url
# }

# output name {
#     value = jsondecode(tostring(data.http.networks.body))
# }


# resource "fortios_firewall_address" "test" {
#   for_each = { for network in jsondecode(data.http.networks.body) : network["name"] => [network]... }
#     name   = each.key
# }

# resource "fortios_firewall_address" "trname" {
#   allow_routing        = "disable"
#   associated_interface = "port2"
#   color                = 3
#   name                 = "testaddress"
#   subnet               = "22.1.1.0/24"
#   type                 = "ipmask"
#   visibility           = "enable"
# }