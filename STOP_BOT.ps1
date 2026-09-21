$ErrorActionPreference = "SilentlyContinue"

Write-Host "Stopping scheduled task..."
schtasks /End /TN "KoakumaLevelBot" | Out-Null

Write-Host "Stopping Koakuma BOT node process..."
$targets = Get-CimInstance Win32_Process | Where-Object {
    $_.Name -eq "node.exe" -and
    $_.CommandLine -and
    (
        $_.CommandLine -like "*koakuma-level-bot*" -or
        $_.CommandLine -like "*src\index.js*" -or
        $_.CommandLine -like "*src/index.js*"
    )
}

if ($targets) {
    foreach ($p in $targets) {
        Stop-Process -Id $p.ProcessId -Force -ErrorAction SilentlyContinue
    }
    Write-Host "Stopped $($targets.Count) BOT process(es)."
} else {
    Write-Host "No matching BOT process was found."
}
