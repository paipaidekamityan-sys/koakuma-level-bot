@echo off
setlocal
title Koakuma Level Bot
cd /d "%~dp0"

if not exist "logs" mkdir "logs"

if not exist "node_modules" (
  echo node_modules was not found.
  echo Run FIRST_SETUP.bat first.
  pause
  exit /b 1
)

:loop
echo [%date% %time%] Starting bot...>>"logs\bot.log"
call npm.cmd start >>"logs\bot.log" 2>&1
set "EXITCODE=%ERRORLEVEL%"

if "%EXITCODE%"=="42" (
  echo [%date% %time%] Another bot instance is already running. This launcher will stop.>>"logs\bot.log"
  exit /b 0
)

echo [%date% %time%] Bot stopped. Restarting in 10 seconds...>>"logs\bot.log"
timeout /t 10 /nobreak >nul
goto loop
