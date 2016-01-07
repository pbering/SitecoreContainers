[CmdLetBinding()]
param(
    [Parameter(Mandatory=$true)]
    [ValidateScript({Test-Path $_ -PathType "Container"})]
    [string]$Path,
    [Parameter(Mandatory=$true)]
    [ValidateNotNullOrEmpty()]
    [string]$Name
)

Import-Module WebAdministration

# Remove default site and pool
Remove-Website -Name "Default Web Site" -ErrorAction SilentlyContinue
Remove-WebAppPool -Name "DefaultAppPool" -ErrorAction SilentlyContinue

# Create pool
$pool = New-WebAppPool -Name $Name
$pool.managedPipelineMode = "Integrated"
$pool.managedRuntimeVersion = "v4.0"
$pool.enable32BitAppOnWin64 = $true
$pool.startMode = "AlwaysRunning"
$pool.processModel.identityType = "LocalSystem"
$pool | Set-Item -Force
$pool.Start()

# Create site
$site = New-Website -Name $Name -ApplicationPool $Name -PhysicalPath $Path -Port 80
$site.Start()