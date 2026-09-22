@echo off
echo changing device name to "main"

powershell -NoProfile -ExecutionPolicy Bypass -Command "Rename-Computer -NewName 'main'"

echo.
echo done
pause