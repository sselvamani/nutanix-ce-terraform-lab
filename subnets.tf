data "nutanix_cluster" "cluster" {}

resource "nutanix_subnet" "lab_subnets" {
  for_each = var.subnets

  name          = each.key
  cluster_uuid  = data.nutanix_cluster.cluster.id
  vlan_id       = each.value.vlan_id
  subnet_type   = "VLAN"
  subnet_ip     = cidrhost(each.value.cidr, 0)
  netmask       = cidrnetmask(each.value.cidr)
  prefix_length = split("/", each.value.cidr)[1]
  default_gateway_ip = each.value.gateway

  dhcp_options { domain_name = "lab.local" }
  dhcp_domain_name_server_list = ["8.8.8.8", "1.1.1.1"]

  ipam_config {
    enabled = true
    pool { range = "${each.value.dhcp_start} ${each.value.dhcp_end}" }
  }

  # Block internet on Sec_Lab
  dynamic "network_function_chain" {
    for_each = each.value.internet ? [] : [1]
    content { name = "NO_INTERNET" }
  }
}