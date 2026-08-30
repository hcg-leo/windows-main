@echo off
echo Changing device name to "main"...

powershell -NoProfile -ExecutionPolicy Bypass -Command "Rename-Computer -NewName 'main'"

echo.
echo Device name updated successfully!
echo NOTE: You must restart your computer for the new name to take effect.
pause