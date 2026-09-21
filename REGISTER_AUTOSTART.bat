@echo off
setlocal
title Koakuma Level Bot Auto Start
cd /d "%~dp0"

set "TASKNAME=KoakumaLevelBot"
set "VBS=%~dp0BOT_START_HIDDEN.vbs"

echo Registering Windows automatic startup...
echo.

rem Stop the existing task before replacing it.
schtasks /End /TN "%TASKNAME%" >nul 2>&1
schtasks /Delete /TN "%TASKNAME%" /F >nul 2>&1

schtasks /Create ^
 /TN "%TASKNAME%" ^
 /TR "wscript.exe ""%VBS%""" ^
 /SC ONLOGON ^
 /RL LIMITED ^
 /F

if errorlevel 1 (
  echo.
  echo [ERROR] Could not register the task.
  echo.
  echo Try these steps:
  echo 1. Right-click this file
  echo 2. Choose Run as administrator
  echo 3. Run it again
  echo.
  pause
  exit /b 1
)

echo.
echo Automatic startup was registered successfully.
echo Starting the bot task now...
echo.

schtasks /Run /TN "%TASKNAME%"

if errorlevel 1 (
  echo.
  echo The task was registered, but could not start now.
  echo It will start the next time you sign in to Windows.
) else (
  echo.
  echo The bot task was started.
)

echo.
pause
