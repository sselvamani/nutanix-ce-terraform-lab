variable "cluster_vip" {
  description = "Nutanix Cluster VIP"
  type        = string
  default     = "172.16.16.200"
}

variable "nutanix_password" {
  description = "Nutanix admin password"
  type        = string
  sensitive   = true
  default     = "" 
}

# Subnet Definitions
variable "subnets" {
  description = "VLAN subnets configuration"
  type = map(object({
    vlan_id    = number
    cidr       = string
    gateway    = string
    dhcp_start = string
    dhcp_end   = string
    internet   = bool
  }))
  default = {
    # VLAN 20: Explicitly set for INTERNET ALWAYS
    "LinuxServers" = {
      vlan_id    = 20
      cidr       = "10.10.20.0/24"
      gateway    = "10.10.20.1"   # <--- Ensure your Physical Router has this IP!
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
    "Sec-Lab" = {
      vlan_id    = 75
      cidr       = "10.10.75.0/24"
      gateway    = "10.10.75.1"
      dhcp_start = "10.10.75.50"
      dhcp_end   = "10.10.75.99"
      internet   = false
    }
  }
}

variable "containers" {
  default = {
    "Linux-Servers"   = 500
    "Windows-Servers" = 500
    "Sec-Lab"         = 100
  }
}

variable "vm_password" {
  description = "Password for the Ubuntu VM user"
  type        = string
  sensitive   = true
  default     = "nutanix/4u" # Default for lab; override with -var or terraform.tfvars
}
