variable "cluster_vip" {
  description = "Nutanix Cluster VIP or CVM IP"
  type        = string
  default     = "172.16.16.200"
}

variable "nutanix_password" {
  description = "Nutanix admin password (set in terraform.tfvars)"
  type        = string
  sensitive   = true
  default     = "" # Empty – override in tfvars for security
}

variable "containers" {
  description = "Storage containers with GB sizes"
  type        = map(number)
  default = {
    "Linux-Servers"   = 500 # GB
    "Windows-Servers" = 500
    "Sec_Lab"         = 100
  }
}

variable "subnets" {
  description = "VLAN subnets with DHCP and internet access control"
  type = map(object({
    vlan_id    = number
    cidr       = string
    gateway    = string
    dhcp_start = string
    dhcp_end   = string
    internet   = bool
  }))
  default = {
    "LinuxServers" = {
      vlan_id    = 20
      cidr       = "10.10.20.0/24"
      gateway    = "10.10.20.1"
      dhcp_start = "10.10.20.50"
      dhcp_end   = "10.10.20.99"
      internet   = true
    }
    "Windows_Servers" = {
      vlan_id    = 30
      cidr       = "10.10.30.0/24"
      gateway    = "10.10.30.1"
      dhcp_start = "10.10.30.50"
      dhcp_end   = "10.10.30.99"
      internet   = true
    }
    "Sec_Lab" = {
      vlan_id    = 75
      cidr       = "10.10.75.0/24"
      gateway    = "10.10.75.1"
      dhcp_start = "10.10.75.50"
      dhcp_end   = "10.10.75.99"
      internet   = false
    }
  }
}