variable "prefix" {
  description = "The prefix which should be used for all resources in this example"
}

variable "location" {
  description = "The Azure Region in which all resources in this example should be created."
  default = "West Europepacker build demo.json"
}

variable "username" {
    description = "Admin"
}

variable "password"{
  description = "Admin password"
}