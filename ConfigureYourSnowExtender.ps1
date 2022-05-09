################## Enter the following details in Powershell to create a Windows Server 2019 with the Snow Extender Installed. ﻿################## 

$resourceGroupName = "SnowSoftware"
$location = "southeastasia"
$adminUsername = "admin"
$adminPassword = Read-Host -Prompt "Enter the administrator password" -AsSecureString
$dnsLabelPrefix = Read-Host -Prompt "Enter an unique DNS name for the public IP"

New-AzResourceGroup -Name $resourceGroupName -Location "$location"
New-AzResourceGroupDeployment `
    -ResourceGroupName $resourceGroupName `
    -TemplateUri "https://raw.githubusercontent.com/nathangreen2021/Snow-Atlas/main/SnowExtender.json" `
    -adminUsername $adminUsername `
    -adminPassword $adminPassword `
    -dnsLabelPrefix $dnsLabelPrefix

 (Get-AzVm -ResourceGroupName $resourceGroupName).name
