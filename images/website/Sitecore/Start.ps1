# Get environment variables
$sqlUser = $env:SQL_USER
$sqlPassword = $env:SQL_PASSWORD
$sqlServer = $env:SQL_SERVER

# Update connection strings
$cfgPath = Join-Path $PSScriptRoot "Website\App_Config\ConnectionStrings.config"
$cfg = Get-Content $cfgPath
$cfg.Replace("user;", "$sqlUser;").Replace("password;", "$sqlPassword;").Replace("(server);", "$sqlServer;") | Out-File $cfgPath -Encoding ASCII

Write-Output "$cfgPath updated"

# Keep container running
ping localhost -t