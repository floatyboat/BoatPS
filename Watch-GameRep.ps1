function Write-Popup {
    param(
        [String]$Message = "Press Ok",
        [String]$Title = 'Title'
    )

    Add-Type -AssemblyName Microsoft.VisualBasic
	[Microsoft.VisualBasic.Interaction]::MsgBox("$Message", 'MsgBoxSetForeground,Information', $Title)
}

function Write-Exercise {
    [CmdletBinding()]
    param(
        [String[]]$Exercise = @("PUSHUPS","PULLUPS","SQAUTS","CRUNCHES")
    )
    $Index = Get-Random -Min 0 -MAx ($Exercise.length - 1)
    Write-Popup -Message "DO $($Exercise[$Index])"
}

function Write-DateVerbose {
    param(
        [String]$Message
    )
    $Date = Get-Date -Format "hh:mm:ss"
    Write-Verbose -Message "$($Date): $Message"
}

function Watch-GameClose {
    param(
        [String]$Name,
        [Int]$Sleep = 60
    )

    $running = $true
    while ($running) {
        Start-Sleep -Seconds $Sleep
        $league = Get-Process $CloseGames -ErrorAction SilentlyContinue
        if ($league) {
            $running = $True
            Write-DateVerbose -Message "$($league.ProcessName) is running..."
        } elseif ($running) {
            $running = $false
            Write-Exercise -Exercise $Exercise
        }
    }
}

function Watch-GameTime {
    param(
        [String]$Name,
        [Int]$Sleep,
        [Int]$RunningTimer
    )
    while (Get-Process $Name) {
        Start-Sleep -Seconds ($RunningTimer * 60)
        Write-Exercise -Exercise $Exercise
    }
}

function Watch-GameRep {
    [CmdletBinding()]
    param (
        [Int]$Sleep = 60,
        [String[]]$CloseGames = @("League of Legends"),
        [String[]]$RunningGames,
        [Int]$RunningTimer = 60,
        [String[]]$Exercise = @("PUSHUPS","PULLUPS","CRUNCHES")
    )

    $TimeGame = $false
    while ($true) {
        $league = Get-Process $CloseGames -ErrorAction SilentlyContinue
        if ($PSBoundParameters.ContainsKey('RunningGames')) {
            $TimeGame = Get-Process $RunningGames -ErrorAction SilentlyContinue
        }
        if ($league) {
            Watch-GameClose -Name $league.ProcessName -Sleep $Sleep
        } elseif ($TimeGame) {
            Watch-GameTime -Name $TimeGame.ProcessName -Sleep $RunningTimer
        } else {
            Write-DateVerbose -Message "No game running..."
        }

        Start-Sleep -Seconds $Sleep
    }
}

Watch-GameRep -Sleep 15 -Verbose