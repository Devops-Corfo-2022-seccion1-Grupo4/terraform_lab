variable "agent_count" {
  default = 1
}
variable "max_count" {
  default = 3
}
variable "min_count" {
  default = 1
}
variable "max_pods" {
  default = 80
}
# The following two variable declarations are placeholder references.
# Set the values for these variable in terraform.tfvars
variable "aks_service_principal_client_id" {
  default = ""
}

variable "aks_service_principal_client_secret" {
  default = ""
}

variable "group" {
    default = "grupo4"
  
}
variable "k8s_version" {
    default = "1.24.6"
  
}

variable "cluster_name" {
  default = "k8scluster"
}

variable "dns_prefix" {
  default = "k8scluster"
}

variable "resource_group_location" {
  default     = "eastus"
  description = "Location of the resource group."
}

variable "resource_group_name_prefix" {
  default     = "rg"
  description = "Prefix of the resource group name that's combined with a random ID so name is unique in your Azure subscription."
}

variable "ssh_public_key" {
  default = "~/.ssh/id_rsa.pub"
}