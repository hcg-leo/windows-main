@echo off
title brave browser profile restore
echo restoring brave "Default" profile from desktop backup
pause

set "SOURCE=%USERPROFILE%\Desktop\backup\browsers\brave\Default"

set "DEST=%LOCALAPPDATA%\BraveSoftware\Brave-Browser\User Data\Default"

echo Restoring Default profile...
xcopy "%SOURCE%" "%DEST%" /E /I /Y /H /C

echo.
echo done
pause
