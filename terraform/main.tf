#Creating Infrastructure in Azure with Terraform
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.46.0"
    }
  }
}
provider "azurerm" {
  features {}
}

# Use packer image "myPackerImage"

data "azurerm_resource_group" "image" {
  name  = "udacity-demo-rg"
}
  data "azurerm_image" "image" {
  name                = var.image
  resource_group_name = data.azurerm_resource_group.image.name

}

#data "azurerm_image" "image" {
  #name = "myPackerImage"
 # resource_group_name = data.udacity-demo-rg
#}

   


# Create the resource group
resource "azurerm_resource_group" "main" {
  name     = "${var.prefix}-resources"
  location = var.location

tags = {
    env = "Production"
    }
}

# Create Virtual Network
resource "azurerm_virtual_network" "main" {
  name                = "${var.prefix}-network"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

  tags = {
    env = "Production"
 }
}

# Create Subnet in above Virtual Network
resource "azurerm_subnet" "main" {
  name                 = "internal"
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = ["10.0.2.0/24"]
}

#Create Network security group and rule
resource "azurerm_network_security_group" "main" {
  name                  ="${var.prefix}-network_security_group"
  location              = azurerm_resource_group.main.location
  resource_group_name   = azurerm_resource_group.main.name

    tags = {
    env = "Production"
 }
    
}



#Create a Network Interface
resource "azurerm_network_interface" "main" {
  count               = var.vm_count
  name                = "${var.prefix}-nic-${count.index}"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location

  ip_configuration {
    name                          = "main"
    subnet_id                     = azurerm_subnet.main.id
    private_ip_address_allocation = "Dynamic"

  }
 tags = {
    env = "Production"
 }   
}

#Create a public IP address

resource "azurerm_public_ip" "main" {
  name                = "${var.prefix}-public-ip"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  allocation_method   = "Static"
  idle_timeout_in_minutes = 20

  tags = {
    env = "Production"
  }
}




#Create a Loadbalancer with backend address pool and backend address pool association for network interface and loadbalancer
resource "azurerm_lb" "main" {
  name                            = "${var.prefix}-lb"
  location                        = azurerm_resource_group.main.location
  resource_group_name             = azurerm_resource_group.main.name

 tags = {
    env = "Production"
  }

  frontend_ip_configuration {
     name                 = "PublicIPAddress"
     public_ip_address_id = azurerm_public_ip.main.id
    }

}


#Backend pool for loadbalancer

resource "azurerm_lb_backend_address_pool" "main" {
  name = "${var.prefix}_lb_backend_address_pool"
  loadbalancer_id = azurerm_lb.main.id
}


#Association of loadbalancer to backend address pool

resource "azurerm_network_interface_backend_address_pool_association" "main" {
  count                           = var.network_interface_count
  network_interface_id = azurerm_network_interface.main[count.index].id
  ip_configuration_name = "internal"
  backend_address_pool_id = azurerm_lb_backend_address_pool.main.id
}


#Create Virtual Machine availability set

resource "azurerm_availability_set" "main" {
    name                            = "${var.prefix}-vm_set"
    location                        = azurerm_resource_group.main.location
    resource_group_name             = azurerm_resource_group.main.name
    managed                         = true

tags = {
    env = "Production"
  }
}


#Create Virtual Machines

resource "azurerm_linux_virtual_machine" "main" {
  count                           = var.vm_count
  name                            = "${var.vm_name_pfx}-${count.index}"
  resource_group_name             = azurerm_resource_group.main.name
  location                        = azurerm_resource_group.main.location
  size                            = "Standard_D2s_v3"
  admin_username                        = "${var.username}"
  admin_password                        = "${var.password}"
  disable_password_authentication = false
tags = {
    env = "Production"
  }

  network_interface_ids = [
    azurerm_network_interface.main[count.index].id
  ]
  source_image_id = data.azurerm_image.image.id

  os_disk {
    storage_account_type = "Standard_LRS"
    caching              = "ReadWrite"
  }

}

