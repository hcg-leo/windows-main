@echo off
powershell -NoProfile -ExecutionPolicy Bypass -Command "Rename-Computer -NewName 'main'"
echo done
pause