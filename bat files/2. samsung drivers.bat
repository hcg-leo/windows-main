@echo off
echo Navigating to driver folder...
cd /d "%USERPROFILE%\Desktop\backup\samsung driver\driver pack"

echo Installing Samsung drivers...
pnputil /add-driver *.inf /subdirs /install

echo.
echo Process finished!
pause
