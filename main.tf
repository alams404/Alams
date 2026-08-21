terraform {
  backend "azurerm" {
    resource_group_name ="alams-tfsate"
    storage_account_name = "alams404"
    container_name      = "mytfstate"
    key = "alamsvm.tfstate"
  }
}



# create resource-group
resource "azurerm_resource_group" "alams-lb" {
  name     = var.resource-name
  location = var.resource-location
}

# public ip for load balancer frontend
resource "azurerm_public_ip" "alams-lb-ip" {
  name                = var.public-ip-name
  location            = azurerm_resource_group.alams-lb.location
  resource_group_name = azurerm_resource_group.alams-lb.name
  allocation_method   = var.allocation
  sku                 = var.sku-type
}

# The load balancer itself
resource "azurerm_lb" "load-balancer" {
  name                = var.load-balancer-name
  location            = azurerm_resource_group.alams-lb.location
  resource_group_name = azurerm_resource_group.alams-lb.name

  frontend_ip_configuration {
    name                 = var.frontend-ip-config
    public_ip_address_id = azurerm_public_ip.alams-lb-ip.id
  }
}

# load balancer backend pool
resource "azurerm_lb_backend_address_pool" "lb-backend-pool" {
  name            = var.backend-pool
  loadbalancer_id = azurerm_lb.load-balancer.id
}

# health probe check for load balancer
resource "azurerm_lb_probe" "health-probe" {
  name            = "health-prob-name"
  loadbalancer_id = azurerm_lb.load-balancer.id
  protocol        = "Http"
  port            = 80
  request_path    = "/"
}

# load balancer rules
resource "azurerm_lb_rule" "lb-rules" {
  name                           = "ib-rules"
  loadbalancer_id                = azurerm_lb.load-balancer.id
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  frontend_ip_configuration_name = azurerm_lb.load-balancer.frontend_ip_configuration[0].name
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.lb-backend-pool.id]
  probe_id                       = azurerm_lb_probe.health-probe.id
}

# output public ip of the load balancer
output "lb_public_ip" {
  value = azurerm_public_ip.alams-lb-ip.ip_address
}

output "backend_pool_id" {
  value = azurerm_lb_backend_address_pool.lb-backend-pool.id
}

