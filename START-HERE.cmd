@echo off
setlocal
cd /d "%~dp0"
where node >nul 2>nul
if errorlevel 1 (
  echo Node.js 18 or later is needed to launch Ember to Ocean.
  echo Install Node.js, then double-click this file again.
  pause
  exit /b 1
)
node serve-local.mjs
pause

