resource "nutanix_virtual_machine" "ubuntu_lite" {
  name         = "Ubuntu-Lite-Terraform"
  cluster_uuid = data.nutanix_cluster.cluster.id
  num_vcpus_per_socket = 2
  num_sockets          = 2
  memory_size_mib      = 4096
  boot_type            = "UEFI"

  disk_list {
    data_source_reference { kind = "image"; uuid = nutanix_image.ubuntu_2204.id }
    device_properties {
      device_type = "DISK"
      disk_address { device_index = 0; adapter_type = "SCSI" }
    }
  }
  disk_list { disk_size_mib = 40 * 1024 }

  nic_list { subnet_uuid = nutanix_subnet.lab_subnets["Linux_Servers"].id }

  guest_customization_cloud_init_user_data = base64encode(file("${path.module}/../cloud-init/ubuntu-cloud-init.yml"))
}