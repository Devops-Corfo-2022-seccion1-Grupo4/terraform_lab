# terraform {
#   required_version = ">=0.12"

#   required_providers {
#     azurerm = {
#       source  = "hashicorp/azurerm"
#       version = "~>2.0"
#     }
#     random = {
#       source  = "hashicorp/random"
#       version = "~>3.0"
#     }
#     tls = {
#       source = "hashicorp/tls"
#       version = "~>4.0"
#     }
#   }
# }

provider "azurerm" {
    subscription_id = "0b71cf90-7326-493e-bddd-19e965b3ae39"
    client_id = "1b34968c-940a-4cb0-848d-51dbf89b841c"
    client_secret =  "mdP8Q~rFc71-kXVHjfMSZ5JhuoUVn1MJeuWGOch~"
    tenant_id = "85047b99-9a7e-4c8e-8950-a89b79c08796"
    features {
      
    }
}