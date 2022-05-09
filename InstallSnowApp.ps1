#Step 1 - Download & Copy the Extender to local path
$Url = 'https://ftp.snowsoftware.com/SetupPackages/CurrentProductVersions/SIM/SetupSIM_5.40.zip' 
	$ZipFile = 'C:\Temp\' + $(Split-Path -Path $Url -Leaf) 
	$Destination= 'C:\Local Folder\' 
    $logdir = """c:\windows\temp\sam_$(get-date -f ddMMyyyy).log"""

	 
	Invoke-WebRequest -Uri $Url -OutFile $ZipFile 
	 
	$ExtractShell = New-Object -ComObject Shell.Application 
	$Files = $ExtractShell.Namespace($ZipFile).Items() 
	$ExtractShell.NameSpace($Destination).CopyHere($Files) 
	Start-Process $Destination



#Step 2 
$Extender = dir $Destination *.exe | Select-Object Name -ExpandProperty name
$RunDir = """$Destination\$Extender"""

write-host "Installing Snow Extender file on OS"
$params = '/s /v"/qn"'


$Runtime = Start-Process -FilePath $RunDir -ArgumentList '/s' -NoNewWindow -wait -PassThru
$Runtime.exitcode


Step 3 - check service is running

$ExtenderService = Get-Service | where-object {$_.name -like "SnowExtender*"}

if ($ExtenderService.status -eq "running")
    {
        write-host "Snow Extender Service is running"
    }
else
    {
        write-host "Please check the Snow Extender as it is not running"
    }

catch
{
    Write-Output "There was an error installing the Snow Extender"
    Write-Output $_
    exit 1
}