variable "prefix" {
  description = "The prefix which should be used for all resources"
  default = "main"
}

variable "udacity-demo-rg" {
    description = ""
    default = "myPackerImage"
    }

variable "location" {
  description = "The Azure Region in which all resources should be created."
  default = "West Europe"
}


variable "username" {
    description = "Login name for virtual machine"
    default = "GlobalAdmin"
 
}

variable "password"{
  description = "Login password for virtual machine"
  default = "Ho$pe!strong1289enough"
}

#variable  "image"  {
#  description = "Image to be used "
#  default = "myPackerImage"
#}

variable "app_port" {
    description = "Port to use for Loadbalancer"
    default = 80
}

#Setting a name prefix to name each VM consistently
variable "vm_name_pfx" {
    description = "VM name"
    default     = "Prod-vm-"
}

#Setting a count variable, a minimum of 2 VMs should be deployed
variable "vm_count" {
    description = "Number of Virtual Machines to deploy"
    type = string
    default     = 2
}

#Setting a count variable for network interfaces
variable "network_interface_count" {
    description = "Number of Network interfaces to deploy"
    type = string
    
}

variable "image" {
    description = "Packer image to be used"
    default = "myPackerImage"
}