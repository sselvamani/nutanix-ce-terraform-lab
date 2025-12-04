resource "nutanix_storage_container" "containers" {
  for_each                       = var.containers
  name                           = each.key
  storage_container_max_capacity = each.value * 1024 * 1024 * 1024 # GB → bytes
}