variable "subscription_id" {
  description = "azure subscription"
  type        = string
  sensitive   = true
  default     = "f0679c99-0d63-422d-93ae-ec929728065c"
}



variable "resource_location" {
  description = "azure resource location"
  type        = string
  default     = "southafricanorth"
}

variable "public_ip_name" {
  description = "load balancer public ip name"
  type        = string
  default     = "alams-lb-ip"
}

variable "allocation" {
  description = "allocation method"
  type        = string
  default     = "Static"
}

variable "sku_type" {
  description = "ip sku type"
  type        = string
  default     = "Standard"
}

variable "load_balancer_name" {
  description = "name of the load-balancer"
  type        = string
  default     = "load-balancer"
}

variable "frontend-ip-config" {
  description = "configuration of frontend ip"
  type        = string
  default     = "load-balancer-frontend-ip"
}

variable "backend-pool" {
  description = "laod balancer backend  pool name"
  type        = string
  default     = "lb-backend-pool"
}

variable "health-prob-name" {
  description = "load balancer health prob name"
  type        = string
  default     = "health-probe"
}


