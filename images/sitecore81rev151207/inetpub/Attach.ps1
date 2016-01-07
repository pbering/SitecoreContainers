[CmdletBinding()]
param(
	[Parameter(Position=0, Mandatory=$true)]
    [ValidateScript({Test-Path $_ -PathType Container})] 
	[string]$Path,
    [Parameter(Position=1, Mandatory=$false)]
    [ValidateNotNullOrEmpty()]
	[string]$Username = "sa",
    [Parameter(Position=1, Mandatory=$false)]
    [ValidateNotNullOrEmpty()]
	[string]$Password = "L@me d`$fault passw0rd"
)

[System.Reflection.Assembly]::LoadWithPartialName("Microsoft.SqlServer.SMO") | Out-Null
[System.Reflection.Assembly]::LoadWithPartialName("Microsoft.SqlServer.SmoExtended") | Out-Null
[System.Reflection.Assembly]::LoadWithPartialName("Microsoft.SqlServer.ConnectionInfo") | Out-Null
[System.Reflection.Assembly]::LoadWithPartialName("Microsoft.SqlServer.SmoEnum") | Out-Null

function Attach-Database
{
    [CmdletBinding()]
    param(
    	[Parameter(Position=0, Mandatory=$true)]
        [ValidateNotNull()]
		[Microsoft.SqlServer.Management.Smo.Server]$Server,
        [Parameter(Position=1, Mandatory=$true)]
        [ValidateNotNullOrEmpty()]
	    [string]$DatabaseName,
        [Parameter(Position=2, Mandatory=$true)]
        [ValidateNotNullOrEmpty()]
	    [string]$DataFilePath,
        [Parameter(Position=3, Mandatory=$true)]
        [ValidateNotNullOrEmpty()]
	    [string]$LogFilePath
	)
    
	$sc = new-object System.Collections.Specialized.StringCollection; 
	$sc.Add($DataFilePath) | Out-Null; 
	$sc.Add($LogFilePath) | Out-Null;
	
    try
    {
        $server.AttachDatabase($DatabaseName, $sc)
    } 
    catch [Exception] 
    {
        Write-Warning "Could not attach database '$DatabaseName', please try again..."
        Write-Error ($_.Exception | Format-List -Force | Out-String)
    }	
}

Write-Host "Attaching databases..."

$ErrorActionPreference = "STOP"

$server = New-Object "Microsoft.SqlServer.Management.Smo.Server"

$connection = $server.ConnectionContext
$connection.LoginSecure = $false
$connection.Login = $Username
$connection.Password = $Password

$server = New-Object "Microsoft.SqlServer.Management.Smo.Server" $connection

$source = $Path

Attach-Database -Server $server -DatabaseName "Sitecore_Analytics" -DataFilePath (Join-Path $source "Sitecore.Analytics.mdf") -LogFilePath (Join-Path $source "Sitecore.Analytics.ldf")
Attach-Database -Server $server -DatabaseName "Sitecore_Core" -DataFilePath (Join-Path $source "Sitecore.Core.mdf") -LogFilePath (Join-Path $source "Sitecore.Core.ldf")
Attach-Database -Server $server -DatabaseName "Sitecore_Master" -DataFilePath (Join-Path $source "Sitecore.Master.mdf") -LogFilePath (Join-Path $source "Sitecore.Master.ldf")
Attach-Database -Server $server -DatabaseName "Sitecore_Web" -DataFilePath (Join-Path $source "Sitecore.Web.mdf") -LogFilePath (Join-Path $source "Sitecore.Web.ldf")
Attach-Database -Server $server -DatabaseName "Sitecore_Sessions" -DataFilePath (Join-Path $source "Sitecore.Sessions.mdf") -LogFilePath (Join-Path $source "Sitecore.Sessions.ldf")

Write-Host "Done"