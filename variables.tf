variable "cluster_vip" {
  description = "Nutanix Cluster IP"
  default     = "172.16.16.200"
}

variable "nutanix_password" {
  description = "Prism Admin Password"
  type        = string
  sensitive   = true
}

variable "vm_password" {
  description = "Default User Password for Linux VMs"
  type        = string
  sensitive   = true
}

variable "subnets" {
  description = "Network Configuration Map"
  default = {
    "LinuxServers" = {
      vlan_id = 10
      cidr    = "10.10.20.0/24"
      gateway = "10.10.20.1"
      start   = "10.10.20.101"
      end     = "10.10.20.150"
    }
    "WindowsServers" = {
      vlan_id = 15
      cidr    = "10.10.25.0/24"
      gateway = "10.10.25.1"
      start   = "10.10.25.50"
      end     = "10.10.25.99"
    }
    "SecLab" = {
      vlan_id = 30
      cidr    = "10.10.30.0/24"
      gateway = "10.10.30.1"
      start   = "10.10.30.30"
      end     = "10.10.30.50"
    }
    "TinyHosts" = {
      vlan_id = 31
      cidr    = "172.31.31.0/24"
      gateway = "172.31.31.1"
      start   = "172.31.31.150"
      end     = "172.31.31.250"
    }
  }
}

# --- Storage Container UUIDs (Manually collected) ---
variable "sc_linux_uuid" {
  description = "UUID for LinuxServers Storage Container"
  type        = string
}

variable "sc_windows_uuid" {
  description = "UUID for WindowsServers Storage Container"
  type        = string
}

variable "sc_tiny_uuid" {
  description = "UUID for TinyHosts Storage Container"
  type        = string
}