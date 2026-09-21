@echo off
setlocal
title Koakuma Level Bot Setup
cd /d "%~dp0"

echo ==========================================
echo   Koakuma Level Bot - First Setup
echo ==========================================
echo.
echo Current folder:
echo %CD%
echo.

where node.exe >nul 2>nul
if errorlevel 1 (
  echo [ERROR] Node.js was not found.
  echo Install Node.js and run this file again.
  echo.
  pause
  exit /b 1
)

echo Node.js:
node.exe -v
echo.

where npm.cmd >nul 2>nul
if errorlevel 1 (
  echo [ERROR] npm.cmd was not found.
  echo Reinstall Node.js.
  echo.
  pause
  exit /b 1
)

if not exist "package.json" (
  echo [ERROR] package.json was not found.
  echo Extract the ZIP completely before running this file.
  echo.
  pause
  exit /b 1
)

if not exist ".env" (
  copy /Y ".env.example" ".env" >nul
  echo .env was created.
  echo Enter DISCORD_TOKEN and CLIENT_ID. GUILD_ID can stay empty.
  echo.
  notepad.exe ".env"
  echo.
  echo Save and close Notepad, then press any key.
  pause >nul
)

echo.
echo Installing packages...
call npm.cmd install
if errorlevel 1 goto install_error

echo.
echo Checking files...
call npm.cmd run check
if errorlevel 1 goto check_error

echo.
echo Registering slash commands...
call npm.cmd run register
if errorlevel 1 goto register_error

echo.
echo ==========================================
echo Setup completed successfully.
echo Next, run BOT_START.bat
echo ==========================================
echo.
pause
exit /b 0

:install_error
echo.
echo [ERROR] npm install failed.
echo Check the error above.
echo.
pause
exit /b 1

:check_error
echo.
echo [ERROR] JavaScript syntax check failed.
echo Check the error above.
echo.
pause
exit /b 1

:register_error
echo.
echo [ERROR] Slash command registration failed.
echo.
echo Most common causes:
echo 1. CLIENT_ID and DISCORD_TOKEN belong to different bots
echo 2. BOT token is invalid
echo 3. Internet connection is unavailable
echo.
echo Fix the cause, then run FIRST_SETUP.bat again.
echo.
pause
exit /b 1
