@echo off
cd /d "%USERPROFILE%\Desktop\backup\samsung driver\driver pack"
pnputil /add-driver *.inf /subdirs /install
pause