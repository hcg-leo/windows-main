@echo off
title Brave Browser Profile Restore
echo Restoring Brave "Default" profile from Desktop backup...
pause

set "SOURCE=%USERPROFILE%\Desktop\backup\browsers\brave\Default"

set "DEST=%LOCALAPPDATA%\BraveSoftware\Brave-Browser\User Data\Default"

echo Restoring Default profile...
xcopy "%SOURCE%" "%DEST%" /E /I /Y /H /C

echo.
echo Brave profile has been successfully replaced in your LocalAppData folder!
pause
