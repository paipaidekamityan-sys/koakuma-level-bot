@echo off
setlocal
title Koakuma Level Bot Debug
cd /d "%~dp0"

if not exist "node_modules" (
  echo Run FIRST_SETUP.bat first.
  pause
  exit /b 1
)

call npm.cmd start
echo.
echo Bot stopped.
pause
