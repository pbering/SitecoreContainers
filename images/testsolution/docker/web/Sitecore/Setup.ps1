# Get environment variables
$sqlPassword = $env:sa_password
$sqlServer = $env:sql_server

# Update connection strings
$cfgPath = Join-Path $PSScriptRoot "Website\App_Config\ConnectionStrings.config"
$cfg = Get-Content $cfgPath
$cfg.Replace("user;", "sa;").Replace("password;", "$sqlPassword;").Replace("(server);", "$sqlServer;") | Out-File $cfgPath -Encoding ASCII

Write-Output "Setup: $cfgPath updated"

# Ready
$ip =  Get-NetAdapter | select -First 1 | Get-NetIPAddress | ? { $_.AddressFamily -eq "IPv4"} | select -Property IPAddress |  % { $_.IPAddress }

Write-Output "Setup: Running on $ip`:80"