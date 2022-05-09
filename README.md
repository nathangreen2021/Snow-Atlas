# Snow-Atlas

Running the ConfigureYourSnowExtender.ps1 script will make the deployment of Snow Software customers infrastructure (Snow Extender & Snow Integration Manager) in Azure.

The script will leverage the custom ARM Template (SnowExtender.json) to install the following Azure services:

A dedicated Resource Group for Snow Extender in a region selected by the customer..
Creates network security groups
- Allows port 443 inbound from anywhere (outside network)
- Allows RDP access for any within 10.0.0.0/24 subnet (can be changed easily)
- Creates an Azure Storage Account


Within that Resource Group it creates a VM classified with:
- Windows Server 2019 datacenter-gensecond
- Size (Standard_D2s_v3) - in line with Snow Software Best Practice.
- Default Name - snowextender
- Adds to the resource group & applies Snow Network Security Rules. 
- Assigns the Snow Extender a public IP
- Creates a DNS alias for the VM in Azure
