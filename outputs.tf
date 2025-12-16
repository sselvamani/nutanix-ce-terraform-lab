output "ubuntu22_ips" {
  value = {
    for vm in nutanix_virtual_machine.ubuntu22 :
    vm.name => vm.nic_list[0].ip_endpoint_list[0].ip
  }
}

output "ubuntu24_ips" {
  value = {
    for vm in nutanix_virtual_machine.ubuntu24 :
    vm.name => vm.nic_list[0].ip_endpoint_list[0].ip
  }
}

output "windows_ip" {
  value = {
    for vm in nutanix_virtual_machine.windows2022 :
    vm.name => try(vm.nic_list[0].ip_endpoint_list[0].ip, "Waiting for IP...")
  }
}

output "tinycore_ips" {
  value = {
    for vm in nutanix_virtual_machine.tinycore :
    vm.name => try(vm.nic_list[0].ip_endpoint_list[0].ip, "Static/DHCP")
  }
}

output "alpine_ips" {
  value = {
    for vm in nutanix_virtual_machine.alpine :
    vm.name => try(vm.nic_list[0].ip_endpoint_list[0].ip, "Static/DHCP")
  }
}