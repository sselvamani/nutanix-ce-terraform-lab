terraform {
  required_version = ">= 1.5.0"
  required_providers {
    nutanix = {
      source  = "nutanix/nutanix"
      version = ">= 1.9.0"
    }
  }
}

provider "nutanix" {
  username = "admin"
  password = var.nutanix_password          # Now from variables (never hardcoded)
  endpoint = var.cluster_vip
  port     = 9440
  insecure = true
}
