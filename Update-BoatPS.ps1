function Update-BoatPS {
    [Alias('ubps')]
    param(
        [String]$Source = $BoatPS_DevSource
    )

    $destination = "$env:USERPROFILE\Documents\PowerShell\Modules\BoatPS"
    Copy-Item -Path $Source -Destination $destination -Recurse -Force
    Import-Module BoatPS -Force
}
