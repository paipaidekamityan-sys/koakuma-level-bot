@echo off
setlocal
title Koakuma Level Bot Auto Start Status

schtasks /Query /TN "KoakumaLevelBot" /V /FO LIST
echo.
pause
