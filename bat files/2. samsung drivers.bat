@echo off
echo navigating to driver folder...
cd /d "%USERPROFILE%\Desktop\backup\samsung driver\driver pack"

echo installing samsung drivers...
pnputil /add-driver *.inf /subdirs /install

echo.
echo process finished
pause
