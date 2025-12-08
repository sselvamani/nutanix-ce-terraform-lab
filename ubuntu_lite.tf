resource "nutanix_virtual_machine" "ubuntu_vms" {
  # 1. Create 2 VMs
  count = 2
  name  = format("SEL-UBU%02d", count.index + 1)

  cluster_uuid         = data.nutanix_cluster.cluster.id
  num_vcpus_per_socket = 2
  num_sockets          = 1
  memory_size_mib      = 4096
  
  # Boot Settings
  boot_type = "LEGACY"
  boot_device_disk_address = {
    device_index = 0
    adapter_type = "SCSI"
  }

  # Disk 1: OS Disk
  disk_list {
    data_source_reference = {
      kind = "image"
      uuid = nutanix_image.ubuntu_2204.id
    }
    device_properties {
      device_type = "DISK"
      disk_address = {
        device_index = 0
        adapter_type = "SCSI"
      }
    }
  }

  # Disk 2: Data Disk
  disk_list {
    disk_size_mib = 40960
    device_properties {
      device_type = "DISK"
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

  # Cloud-Init with Template Variable
  guest_customization_cloud_init_user_data = base64encode(templatefile("${path.module}/cloud-init/ubuntu-cloud-init.yml", {
    vm_password = var.vm_password
  }))
}
