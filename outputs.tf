# --- LINUX SERVERS (Use tfvars password) ---
output "ubuntu22_info" {
  description = "Ubuntu 22.04 Login Details"
  value = {
    for vm in nutanix_virtual_machine.ubuntu22 :
    vm.name => {
      ip       = try(vm.nic_list[0].ip_endpoint_list[0].ip, "Waiting...")
      username = "ubuntu"
      password = "See 'vm_password' in terraform.tfvars"
    }
  }
}

output "ubuntu24_info" {
  description = "Ubuntu 24.04 Login Details"
  value = {
    for vm in nutanix_virtual_machine.ubuntu24 :
    vm.name => {
      ip       = try(vm.nic_list[0].ip_endpoint_list[0].ip, "Waiting...")
      username = "ubuntu"
      password = "See 'vm_password' in terraform.tfvars"
    }
  }
}

# --- WINDOWS SERVER (Manual Install) ---
output "windows_info" {
  description = "Windows Server 2022 Login Details"
  value = {
    for vm in nutanix_virtual_machine.windows2022 :
    vm.name => {
      ip       = try(vm.nic_list[0].ip_endpoint_list[0].ip, "Waiting...")
      username = "Administrator"
      password = "Set manually during OS installation"
    }
  }
}

# --- TINY HOSTS (No Password) ---
output "tinycore_info" {
  description = "TinyCore Login Details"
  value = {
    for vm in nutanix_virtual_machine.tinycore :
    vm.name => {
      ip       = try(vm.nic_list[0].ip_endpoint_list[0].ip, "Waiting...")
      username = "tc"
      password = "(No Password)"
    }
  }
}

output "alpine_info" {
  description = "Alpine Linux Login Details"
  value = {
    for vm in nutanix_virtual_machine.alpine :
    vm.name => {
      ip       = try(vm.nic_list[0].ip_endpoint_list[0].ip, "Waiting...")
      username = "root"
      password = "See 'vm_password' in terraform.tfvars"
    }
  }
}