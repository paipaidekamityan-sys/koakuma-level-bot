@echo off
setlocal
title Remove Koakuma Level Bot Auto Start

schtasks /End /TN "KoakumaLevelBot" >nul 2>&1
schtasks /Delete /TN "KoakumaLevelBot" /F

echo.
echo Windows automatic startup was removed.
echo.
pause
