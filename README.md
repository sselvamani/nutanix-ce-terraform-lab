# Nutanix CE + Terraform Homelab  
**Physical 4-node Nutanix Community Edition cluster – 100 % automated with Terraform**

![Nutanix CE](https://img.shields.io/badge/Nutanix-CE-orange) 
![Terraform](https://img.shields.io/badge/Terraform-1.9%2B-5F43E2?logo=terraform) 
![AHV](https://img.shields.io/badge/Hypervisor-AHV-blue) 
![License](https://img.shields.io/badge/License-MIT-green)

Real hardware (4 × Dell OptiPlex) • Latest AOS/CE • Cluster VIP `172.16.16.200`

### Lab Topology
| Node  | Host IP         | CVM IP          | Role           |
|-------|-----------------|-----------------|----------------|
| NU01  | 172.16.16.101   | 172.16.16.201   | Cluster member |
| NU02  | 172.16.16.102   | 172.16.16.202   | Cluster member |
| NU03  | 172.16.16.103   | 172.16.16.203   | Cluster member |
| NU04  | 172.16.16.104   | 172.16.16.204   | Cluster member |

### What this repo creates with a single `terraform apply`
- Cluster Management
- 3 storage containers  
  → Linux_Servers (500 GB) | Windows_Servers (500 GB) | Sec_Lab (100 GB)
- 3 VLAN subnets with DHCP  
  → VLAN 50  (Linux)   – full internet  
  → VLAN 100 (Windows) – full internet  
  → VLAN 75  (Sec_Lab) – **zero internet** (blocked via Flow NFC)
- Ubuntu 22.04 cloud-init VMs (instant boot + SSH-ready)
- Windows Server 2022 / Windows 10 / Windows 11 VMs (ISO ready)
- Automatic snapshots + instant linked clones (golden-image workflow)
- Flow micro-segmentation ready for Sec_Lab

### Quick Start
```bash
git clone https://github.com/sselvamani/nutanix-ce-terraform-lab.git
cd nutanix-ce-terraform-lab
terraform init
terraform plan
terraform apply -auto-approve

## Folder structure 
├── provider.tf
├── variables.tf
├── storage_containers.tf
├── subnets.tf
├── images.tf
├── vms/
│   ├── ubuntu_lite.tf
│   ├── windows_2022.tf
│   ├── windows_10.tf
│   ├── windows_11.tf
│   ├── snapshots.tf
│   └── clones.tf
└── cloud-init/
