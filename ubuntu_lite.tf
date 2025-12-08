resource "nutanix_virtual_machine" "ubuntu_lite" {
  name                 = "Ubuntu-Lite-Terraform"
  cluster_uuid         = data.nutanix_cluster.cluster.id
  num_vcpus_per_socket = 2
  num_sockets          = 1
  memory_size_mib      = 4096
  boot_type            = "UEFI"

  # Disk 1: Clone from Image (The OS Disk)
  disk_list {
    # FIX: Use '=' for data_source_reference (Required for v1.9.5)
    data_source_reference = {
      kind = "image"
      uuid = nutanix_image.ubuntu_2204.id
    }

    device_properties {
      device_type = "DISK"
      # FIX: Use '=' for disk_address
      disk_address = {
        device_index = 0
        adapter_type = "SCSI"
      }
    }
  }

  # Disk 2: Data Disk (40GB)
  disk_list {
    disk_size_mib = 40960
    device_properties {
      device_type = "DISK"
      # FIX: Use '=' for disk_address
      disk_address = {
        device_index = 1
        adapter_type = "SCSI"
      }
    }
  }

  # Network Interface
  nic_list {
    subnet_uuid = nutanix_subnet.lab_subnets["LinuxServers"].id
  }

  # Cloud-Init User Data
  guest_customization_cloud_init_user_data = base64encode(file("${path.module}/cloud-init/ubuntu-cloud-init.yml"))
}
