# --- DATA SOURCES ---

# 1. NEW: Your Golden Windows Image
data "nutanix_image" "win_golden" {
  image_name = "Windows2022-Golden"
}

# 2. Ubuntu Images
data "nutanix_image" "ubuntu22" {
  image_name = "Ubuntu22-Jammy"
}
data "nutanix_image" "ubuntu24" {
  image_name = "Ubuntu24-Noble"
}

# 3. Tiny/Alpine Images
data "nutanix_image" "tinycore" {
  image_name = "TinyCore-16"
}
data "nutanix_image" "alpine" {
  image_name = "Alpine-3.23"
}

# --- RESOURCES ---

# 1. UBUNTU 22
resource "nutanix_virtual_machine" "ubuntu22" {
  count = var.ubuntu22_count
  name  = format("Selva-U22-%02d", count.index + 1)
  cluster_uuid = data.nutanix_cluster.cluster.id
  num_vcpus_per_socket = 1
  num_sockets          = 1
  memory_size_mib      = 1024

  guest_customization_cloud_init_user_data = base64encode(<<EOF
#cloud-config
password: ${var.vm_password}
chpasswd: { expire: False }
ssh_pwauth: True
EOF
  )

  disk_list {
    disk_size_mib = 20480
    data_source_reference = {
      kind = "image"
      uuid = data.nutanix_image.ubuntu22.id
    }
  }
  nic_list {
    subnet_uuid = nutanix_subnet.lab_subnets["LinuxServers"].id
  }
}

# 2. UBUNTU 24
resource "nutanix_virtual_machine" "ubuntu24" {
  count = var.ubuntu24_count
  name  = format("Selva-U24-%02d", count.index + 1)
  cluster_uuid = data.nutanix_cluster.cluster.id
  num_vcpus_per_socket = 1
  num_sockets          = 1
  memory_size_mib      = 1024

  guest_customization_cloud_init_user_data = base64encode(<<EOF
#cloud-config
password: ${var.vm_password}
chpasswd: { expire: False }
ssh_pwauth: True
EOF
  )

  disk_list {
    disk_size_mib = 20480
    data_source_reference = {
      kind = "image"
      uuid = data.nutanix_image.ubuntu24.id
    }
  }
  nic_list {
    subnet_uuid = nutanix_subnet.lab_subnets["LinuxServers"].id
  }
}

# 3. WINDOWS SERVER 2022 (From Golden Image)
resource "nutanix_virtual_machine" "windows2022" {
  count = var.windows_count
  name  = format("Selva-Win2022-%02d", count.index + 1)
  cluster_uuid = data.nutanix_cluster.cluster.id

  num_vcpus_per_socket = 1
  num_sockets          = 2
  memory_size_mib      = 4096 

  # Single Disk: CLONE from your Golden Image
  disk_list {
    disk_size_mib = 61440
    data_source_reference = {
      kind = "image"
      uuid = data.nutanix_image.win_golden.id
    }
  }

  nic_list {
    subnet_uuid = nutanix_subnet.lab_subnets["WindowsServers"].id
  }
}

# 4. TINY CORE
resource "nutanix_virtual_machine" "tinycore" {
  count = var.tiny_count
  name  = format("Selva-Tiny-%02d", count.index + 1)
  cluster_uuid = data.nutanix_cluster.cluster.id
  num_vcpus_per_socket = 1
  num_sockets          = 1 
  memory_size_mib      = 256 

  disk_list {
    device_properties {
      device_type = "CDROM"
      disk_address = { adapter_type = "IDE", device_index = 0 }
    }
    data_source_reference = {
      kind = "image"
      uuid = data.nutanix_image.tinycore.id
    }
  }
  disk_list {
    disk_size_mib = 2048
    device_properties { device_type = "DISK" }
    storage_config {
      storage_container_reference {
        kind = "storage_container"
        uuid = var.sc_tiny_uuid
      }
    }
  }
  nic_list {
    subnet_uuid = nutanix_subnet.lab_subnets["TinyHosts"].id
  }
}

# 5. ALPINE LINUX
resource "nutanix_virtual_machine" "alpine" {
  count = var.tiny_count
  name  = format("Selva-Alpine-%02d", count.index + 1)
  cluster_uuid = data.nutanix_cluster.cluster.id
  num_vcpus_per_socket = 1
  num_sockets          = 1
  memory_size_mib      = 512

  guest_customization_cloud_init_user_data = base64encode(<<EOF
#cloud-config
chpasswd:
  list: |
    root:${var.vm_password}
  expire: False
ssh_pwauth: True
disable_root: False
EOF
  )

  disk_list {
    disk_size_mib = 1024
    data_source_reference = {
      kind = "image"
      uuid = data.nutanix_image.alpine.id
    }
  }
  nic_list {
    subnet_uuid = nutanix_subnet.lab_subnets["TinyHosts"].id
  }
}