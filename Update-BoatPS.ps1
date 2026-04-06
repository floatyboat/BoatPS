function Update-BoatPS {
    [Alias('ubps')]
    param(
        [String]$Source = $BoatPS_DevSource
    )

    $destination = "$env:USERPROFILE\Documents\WindowsPowerShell\Modules\BoatPS"
    if (-not (Test-Path $destination)) { New-Item -Path $destination -ItemType Directory | Out-Null }
    Copy-Item -Path "$Source\*" -Destination $destination -Recurse -Force
    Import-Module BoatPS -Force
}
