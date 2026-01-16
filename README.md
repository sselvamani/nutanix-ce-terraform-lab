# Nutanix CE + Terraform Homelab  
![Nutanix CE](https://img.shields.io/badge/Nutanix-CE-orange)  ![AHV](https://img.shields.io/badge/Hypervisor-AHV-blue)   ![Terraform](https://img.shields.io/badge/Terraform-7B42BC?logo=terraform&logoColor=white)  ![Self Learner](https://img.shields.io/badge/Learning-Self%20Learner-10B981?logo=bookstack) ![Home Lab](https://img.shields.io/badge/Lab-Home%20Lab-6366F1?logo=proxmox)
![Self Paced](https://img.shields.io/badge/Mode-Self%20Paced-F59E0B?logo=clockify)  ![License](https://img.shields.io/badge/License-MIT-green)

**Physical 4-node Nutanix Community Edition cluster – 100 % automated with Terraform**
Real hardware (4 × Dell OptiPlex) • Latest AOS/CE • Cluster VIP `172.16.16.200`

### Lab Topology
| Node  | Host IP         | CVM IP          | Role           |
|-------|-----------------|-----------------|----------------|
| NU01  | 172.16.16.101   | 172.16.16.201   | Cluster member |
| NU02  | 172.16.16.102   | 172.16.16.202   | Cluster member |
| NU03  | 172.16.16.103   | 172.16.16.203   | Cluster member |
| NU04  | 172.16.16.104   | 172.16.16.204   | Cluster member |


### Quick Start
```bash
git clone https://github.com/sselvamani/nutanix-ce-terraform-lab.git
cd nutanix-ce-terraform-lab
terraform init
terraform plan
terraform apply


Thankyou !!!

