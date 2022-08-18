#Step 1 - Download & Copy the Extender to local path

$Url = "https://github.com/nathangreen2021/Snow-Atlas/raw/main/ExtenderSetup_with_silent_install.zip"
$DownloadZipFile = "C:\temp\" + $(Split-Path -Path $Url -Leaf)
$Destination = "C:\temp\"
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

if (Test-Path $Destination) {
   
    Write-Host "Folder Already Exists, overwriting content"
    Copy-Item -Force -Recurse $Destination
    
}
else
{
  
    New-Item $Destination -ItemType Directory
    Write-Host "Folder Created successfully"
}

Invoke-WebRequest -Uri $Url -OutFile $DownloadZipFile -Verbose
$ExtractShell = New-Object -ComObject Shell.Application 
$ExtractFiles = $ExtractShell.Namespace($DownloadZipFile).Items() 
$ExtractShell.NameSpace($Destination).CopyHere($ExtractFiles) 
Start-Process $Destination


$logdir = """c:\windows\temp\sam_$(get-date -f ddMMyyyy).log"""


#Step 2 - Install The Extender
$Extender = dir $Destination *.exe | Select-Object Name -ExpandProperty name
$RunDir = """$Destination\$Extender"""

write-host "Installing Snow Extender file on your server, please wait.."
$params = '-silent'


$Runtime = Start-Process -FilePath $RunDir -ArgumentList $params -NoNewWindow -wait -PassThru
$Runtime.exitcode


#Step 3 - check service is running

$ExtenderService = Get-Service | where-object {$_.name -like "SnowExtender*"}

if ($ExtenderService.status -eq "running")
    {
        write-host "Snow Extender Service is running & has been successfully enrolled!"
    }
elseif($ExtenderService.status -ne "running")
    {
        write-host "Snow Extender Service successfully installed, please enroll."
    }

else
{
    Write-Output "There was an error installing the Snow Extender; ensure you got access!"
    Write-Output $_
    exit 1
}
