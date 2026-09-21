@echo off
setlocal
title Koakuma BOT - Stop Old Instances
cd /d "%~dp0"

echo [1/2] Stopping scheduled task if it is running...
schtasks /End /TN "KoakumaLevelBot" >nul 2>&1

echo [2/2] Stopping Koakuma BOT node process...
powershell.exe -NoProfile -ExecutionPolicy Bypass -Command "$ErrorActionPreference='SilentlyContinue'; Get-CimInstance Win32_Process | Where-Object { $_.Name -eq 'node.exe' -and $_.CommandLine -and (($_.CommandLine -like '*koakuma-level-bot*') -or ($_.CommandLine -like '*src\index.js*') -or ($_.CommandLine -like '*src/index.js*')) } | ForEach-Object { Stop-Process -Id $_.ProcessId -Force }"

echo.
echo Stop command finished.
echo If the BOT is still online in Discord, wait a few seconds and run this file once more.
echo.
pause
endlocal
