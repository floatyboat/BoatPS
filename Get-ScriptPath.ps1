function Get-ScriptPath {
    param(
        [String]$Name,
        [String]$ModulePath = $PSScriptRoot
    )

    $SearchPath = "$ModulePath*$Name"
    Get-Item -Path $SearchPath | Select-Object -ExpandProperty FullName
}