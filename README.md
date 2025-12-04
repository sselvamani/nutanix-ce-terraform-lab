# Nutanix CE + Terraform Homelab

Physical 4-node Nutanix Community Edition cluster 

## Lab Topology
| Node  | Host IP         | CVM IP          | Role             |
|-------|-----------------|-----------------|------------------|
| NU01  | 172.16.16.101   | 172.16.16.201   | Cluster member   |
| NU02  | 172.16.16.102   | 172.16.16.202   | Cluster member   |
| NU03  | 172.16.16.103   | 172.16.16.203   | Cluster member   |
| NU04  | 172.16.16.104   | 172.16.16.204   | Cluster member   |

## Quick Start
```bash
terraform init
terraform plan
terraform apply
