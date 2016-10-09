# Get environment variables
$sqlUser = $env:SQL_USER
$sqlPassword = $env:SQL_PASSWORD
$sqlServer = $env:SQL_SERVER

# Update connection strings
$cfgPath = Join-Path $PSScriptRoot "Website\App_Config\ConnectionStrings.config"
$cfg = Get-Content $cfgPath
$cfg.Replace("user;", "$sqlUser;").Replace("password;", "$sqlPassword;").Replace("(server);", "$sqlServer;") | Out-File $cfgPath -Encoding ASCII

Write-Output "$cfgPath updated"

# Ready
$containerIp =  Get-NetAdapter | select -First 1 | Get-NetIPAddress | ? { $_.AddressFamily -eq "IPv4"} | select -Property IPAddress |  % { $_.IPAddress }

Write-Output "Waiting on first request to $containerIp..."

# Keep container running
. C:\Sitecore\UDP.ps1