[CmdletBinding()]
param(
    # Path to keep updated with changes from Source path
    [Parameter(Mandatory=$true)]
    [ValidateScript({Test-Path $_ -PathType 'Container'})] 
    $Path,
    # Source path to use to keep Path updated
    [Parameter(Mandatory=$true)]
    [ValidateScript({Test-Path $_ -PathType 'Container'})] 
    $Source,
    # Array of filename patterns (-like operator) to watch 
    [Parameter(Mandatory=$false)]
    [array]$Filters
)

Write-Host ("{0}: Watching..."-f [DateTime]::Now.ToLongTimeString())
              
while($true)
{           
    Write-Verbose "Checking '$Source'..."

    Get-ChildItem -Path $Source | ? { Test-Path $_.FullName -PathType Leaf } | % {
        $triggerReason = $null     
        $sourceFilename = $_.Name
        $matches = if($Filters -ne $null -and $Filters.Length -gt 0) {
            :filter foreach($filter in $Filters) {
                if($sourceFilename -like $filter)
                {
                    $true
                    break :filter
                }
            }
        } 
        else
        {
            $true
        }
          
        if($matches) 
        {
            $targetFilePath = Join-Path $Path $sourceFilename

            if(Test-Path -Path $targetFilePath -PathType Leaf) 
            {
                Compare-Object $_ (Get-Item $targetFilePath) -Property Name, Length, LastWriteTime | % {
                    $triggerReason = "Different"
                }
            }
            else
            {
                $triggerReason = "Missing"
            }
                   
            if($triggerReason -ne $null)
            {
                Copy-Item -Path $_.FullName -Destination $targetFilePath -Force

                Write-Host ("{0}: Copied '{1}' to target, was '{3}'" -f [DateTime]::Now.ToLongTimeString(), $sourceFilename, $targetPath, $triggerReason)
            }
        }
        else
        {
            Write-Verbose ("Source file '{0}' was ignored by filter" -f $_.Name)
        }               
    }
            
    Sleep -Milliseconds 1000
}