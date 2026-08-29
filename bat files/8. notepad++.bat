@echo off
setlocal

echo Notepad++ setup: Nord theme + hide toolbar
echo -------------------------------------------
echo.

set "SCRIPT_DIR=%~dp0"

if not exist "%SCRIPT_DIR%apply-nord-theme.ps1" (
    echo [ERROR] apply-nord-theme.ps1 was not found next to this .bat file.
    echo         Keep both files in the same folder, then run this again.
    pause
    exit /b 1
)

powershell -NoProfile -ExecutionPolicy Bypass -File "%SCRIPT_DIR%apply-nord-theme.ps1"

echo.
pause
