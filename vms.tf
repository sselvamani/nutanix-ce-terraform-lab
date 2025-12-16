# --- DATA SOURCE: Find Manually Uploaded Windows ISO ---
data "nutanix_image" "win2022" {
  image_name = "WINServer2022"
}

# --- 1. UBUNTU 22 (1 vCPU, 1GB RAM, 20GB Disk) ---
resource "nutanix_virtual_machine" "ubuntu22" {
  count = 2
  name  = format("Selva-U22-%02d", count.index + 1)
  cluster_uuid = data.nutanix_cluster.cluster.id

  num_vcpus_per_socket = 1
  num_sockets          = 1
  memory_size_mib      = 1024

  disk_list {
    # 20GB Data Disk
    disk_size_mib = 20480
    
    # Needs '=' (Argument)
    data_source_reference = {
      kind = "image"
      uuid = nutanix_image.ubuntu_22.id
    }
    
    storage_config {
      # No '=' (Block)
      storage_container_reference {
        kind = "storage_container"
        uuid = var.sc_linux_uuid
      }
    }
  }

  nic_list {
    subnet_uuid = nutanix_subnet.lab_subnets["LinuxServers"].id
  }
}

# --- 2. UBUNTU 24 (1 vCPU, 1GB RAM, 20GB Disk) ---
resource "nutanix_virtual_machine" "ubuntu24" {
  count = 2
  name  = format("Selva-U24-%02d", count.index + 1)
  cluster_uuid = data.nutanix_cluster.cluster.id

  num_vcpus_per_socket = 1
  num_sockets          = 1
  memory_size_mib      = 1024

  disk_list {
    disk_size_mib = 20480
    
    # Needs '='
    data_source_reference = {
      kind = "image"
      uuid = nutanix_image.ubuntu_24.id
    }
    
    storage_config {
      # No '='
      storage_container_reference {
        kind = "storage_container"
        uuid = var.sc_linux_uuid
      }
    }
  }

  nic_list {
    subnet_uuid = nutanix_subnet.lab_subnets["LinuxServers"].id
  }
}

# --- 3. WINDOWS SERVER 2022 (2 vCPU, 2GB RAM, 60GB Disk) ---
resource "nutanix_virtual_machine" "windows2022" {
  count = 1
  name  = format("Selva-Win2022-%02d", count.index + 1)
  cluster_uuid = data.nutanix_cluster.cluster.id

  num_vcpus_per_socket = 1
  num_sockets          = 2
  memory_size_mib      = 2048

  # Disk 1: CDROM (The ISO)
  disk_list {
    # No '='
    device_properties {
      device_type = "CDROM"
      disk_address = {
        adapter_type = "IDE"
        device_index = 0
      }
    }
    # Needs '='
    data_source_reference = {
      kind = "image"
      uuid = data.nutanix_image.win2022.id
    }
  }

  # Disk 2: C Drive (60GB)
  disk_list {
    disk_size_mib = 61440
    
    # No '='
    device_properties {
      device_type = "DISK"
    }
    
    storage_config {
      # No '='
      storage_container_reference {
        kind = "storage_container"
        uuid = var.sc_windows_uuid
      }
    }
  }

  nic_list {
    subnet_uuid = nutanix_subnet.lab_subnets["WindowsServers"].id
  }
}

# --- 4. TINY CORE (0.5 vCPU, 0.25GB RAM, 2GB Disk) ---
resource "nutanix_virtual_machine" "tinycore" {
  count = 2
  name  = format("Selva-Tiny-%02d", count.index + 1)
  cluster_uuid = data.nutanix_cluster.cluster.id

  num_vcpus_per_socket = 1
  num_sockets          = 1 
  memory_size_mib      = 256 

  # Disk 1: CDROM (The ISO)
  disk_list {
    # No '='
    device_properties {
      device_type = "CDROM"
      disk_address = {
        adapter_type = "IDE"
        device_index = 0
      }
    }
    # Needs '='
    data_source_reference = {
      kind = "image"
      uuid = nutanix_image.tinycore.id
    }
  }

  # Disk 2: Data Disk (2GB)
  disk_list {
    disk_size_mib = 2048
    
    # No '='
    device_properties {
      device_type = "DISK"
    }
    
    storage_config {
      # No '='
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

# --- 5. ALPINE LINUX (0.5 vCPU, 512MB RAM, 1GB Disk) ---
resource "nutanix_virtual_machine" "alpine" {
  count = 2
  name  = format("Selva-Alpine-%02d", count.index + 1)
  cluster_uuid = data.nutanix_cluster.cluster.id

  num_vcpus_per_socket = 1
  num_sockets          = 1
  memory_size_mib      = 512

  # Disk 1: OS (1GB)
  disk_list {
    disk_size_mib = 1024
    
    # Needs '='
    data_source_reference = {
      kind = "image"
      uuid = nutanix_image.alpine.id
    }
    
    storage_config {
      # No '='
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