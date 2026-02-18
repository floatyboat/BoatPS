$ScriptPAth = "$($env:USERPROFILE)\Documents\Watch-GameRep.ps1"
if (-not (Test-PAth $ScriptPAth)) {
       New-Item -ItemType File -Path $ScriptPAth
}

"function Write-Popup {
    param(
        [String]`$Message
    )

    `$wshell = New-Object -ComObject Wscript.Shell
    `$wshell.Popup(`$Message) | Out-Null
}

function Watch-GameRep {
    [CmdletBinding()]
    param (
        [Int]`$Sleep = 60,
        [String[]]`$Games = @(`"League of Legends`"),
        [String[]]`$Exercise = @(`"PUSHUPS`",`"PULLUPS`",`"SQAUTS`",`"CRUNCHES`")
    )

    `$running = `$false

    while (`$true) {
        `$league = Get-Process `$Games -ErrorAction SilentlyContinue
        `$DAte = Get-Date -Format `"hh:mm:ss`"
        if (`$league) {
            `$running = `$True
            Write-Verbose -Message `"`$(`$Date): `$(`$league.ProcessName) is running...`"
        } elseif (`$running) {
            `$running = `$false
            `$Index = Get-Random -Min 0 -MAx (`$Exercise.length - 1)
            Write-Popup -Message `"DO `$(`$Exercise[`$Index])`"
        } else {
            Write-Verbose -Message `"`$(`$Date): No game running...`"
        }

        Start-Sleep -Seconds `$Sleep
    }
}

Watch-GameRep -Sleep 60" | Out-File $ScriptPAth
$Action = New-ScheduledTaskAction -Execute "powershell.exe" -Argument "-ExecutionPolicy Bypass -File `"$($ScriptPAth)`""
$Trigger = New-ScheduledTaskTrigger -AtLogOn 
$Description = "Task to check running games and trigger a rep reminder when game closes."
New-ScheduledTask -Description $Description -Action $Action -Trigger $Trigger | Register-ScheduledTask -TaskName "Watch-GameRep" -Force