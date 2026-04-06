function Start-Project {
    [Alias('stp')]
    param(
        [String]$Project = 'packmine',
        [Switch]$Docker,
        [Switch]$Code,
        [Switch]$Wsl
    )

    $all = -not ($Docker -or $Code -or $Wsl)

    if ($all -or $Docker) {
        Start-Process 'C:\Program Files\Docker\Docker\Docker Desktop.exe'
    }

    if ($all -or $Code) {
        Start-Process $BoatPS_CodePath `
            -ArgumentList '--remote', "wsl+Ubuntu", "$BoatPS_WslDevPath/$Project"
    }

    if ($all -or $Wsl) {
        wsl --cd "$BoatPS_WslDevPath/$Project"
    }
}
