Write-Host "HELLO CONFIGURE"
$sqlUser = $env:SQL_USER
$sqlPassword = $env:SQL_PASSWORD
$sqlServer = $env:SQL_SERVER

if($sqlUser -eq "_" -or $sqlPassword -eq "_" -or $sqlServer -eq "_")
{
    Write-Verbose "Default setting found, skipping"
    Write-Host "HELLO CONFIGURE SKIP"
    return
}

$cfgPath = Join-Path $PSScriptRoot "Website\App_Config\ConnectionStrings.config"
$cfg = Get-Content $cfgPath
$cfg.Replace("user;", "$sqlUser;").Replace("password;", "$sqlPassword;").Replace("(server);", "$sqlServer;") | Out-File $cfgPath -Encoding ascii

Write-Verbose "$cfgPath updated"
Write-Host "HELLO CONFIGURE END"
while($true) { sleep -Seconds 1}