@echo off
:: run as administrator
cd /d "%~dp0.."

powershell -c "Rename-Computer -NewName 'main' -Force"
if exist drivers pnputil /add-driver "drivers\*.inf" /subdirs /install
pause
