$ErrorActionPreference = "STOP"

# Find solution name
$solution = (Get-Item $PSScriptRoot).Name.ToLowerInvariant()

# Build containers
Write-Host "Building..." -ForegroundColor Green

$containers = @()

Get-ChildItem -Path (Join-Path $PSScriptRoot "docker") | % {
    Push-Location -Path $_.FullName
    
    $containerName = "$solution-$($_.BaseName)"

    # Remove if running
    docker ps --all --filter Name=$containerName -q | % { docker rm --force $_ }

    # Build
    docker build -t $containerName -q .

    $containers += $containerName
    
    Pop-Location
}

# Run containers
Write-Host "Running..." -ForegroundColor Green

$sqlPassword = "Sitecore_Containers_Rocks_9999"

$containers | % {
    if($_ -like "*-sql")
    {
        $volume = (Join-Path $PSScriptRoot "\docker\sql\Sitecore\Databases").Replace("\", "/")

        docker run -d -p "1433:1433" --env "sa_password=$sqlPassword" --name $_ --volume "$volume`:C:/Data" $_
    } 
    elseif($_ -like "*-website")
    {
        $volume = (Join-Path $PSScriptRoot "\src\Website").Replace("\", "/")

        docker run -d -p "8000:8000" --env "SQL_USER=sa" --env "SQL_PASSWORD=$sqlPassword" --env "SQL_SERVER=$solution-sql" --name $_ --link "$solution-sql" --volume "$volume`:C:/Workspace" $_

        Write-Host ("IP of '{0}': {1}" -f $_, (docker inspect $_ | ConvertFrom-Json).NetworkSettings.Networks."nat".IPAddress)
    } 
    else
    {
        Write-Error "Unhandled container '$_'"
    }
}

Write-Host "Ready" -ForegroundColor Green