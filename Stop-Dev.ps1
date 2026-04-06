function Stop-Dev {
    [Alias('sd')]
    param(
        [Switch]$Code,
        [Switch]$Docker,
        [Switch]$Wsl
    )

    $all = -not ($Code -or $Docker -or $Wsl)

    if ($all -or $Code) {
        Stop-Process -Name 'Code' -Force -ErrorAction SilentlyContinue
    }

    if ($all -or $Docker) {
        Stop-Process -Name 'Docker Desktop', 'com.docker.backend', 'com.docker.build' -Force -ErrorAction SilentlyContinue
    }

    if ($all -or $Wsl) {
        wsl --shutdown
    }
}
