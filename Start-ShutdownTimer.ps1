$MaxExtensions = 3
$ExtensionMinutes = 5
$PopupTimeoutSeconds = 300

$extensions = 0
$shell = New-Object -ComObject WScript.Shell

while ($true) {
    $remaining = $MaxExtensions - $extensions
    [Console]::Beep(800, 300)
    [Console]::Beep(1000, 300)
    [Console]::Beep(800, 300)
    $result = $shell.Popup(
        "$ExtensionMinutes more minutes? ($remaining extensions remaining)",
        $PopupTimeoutSeconds,
        "Shutdown Timer",
        52
    )

    if ($result -eq 6) {
        $extensions++
        if ($extensions -ge $MaxExtensions) {
            Stop-Computer -Force
        }
        Start-Sleep -Seconds ($ExtensionMinutes * 60)
    } else {
        Stop-Computer -Force
    }
}
