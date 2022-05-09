# Snow-Atlas

Create a dedicated Resource Group for Snow Extender (I chose South East Asia but can be anywhere).
Creates network security groups
- Allows port 443 inbound from anywhere (outside network)
- Allows RDP access for any within 10.0.0.0/24 subnet (can be changed easily)
- Creates an Azure Storage Account


Creates a VM:
- Windows Server 2019 datacenter-gensecond
- Size (Standard_D2s_v3) - in line with best practice.
- Name snowextender
- Adds to the resource group & applies security rules. (Assigns a public IP & DNS too)
