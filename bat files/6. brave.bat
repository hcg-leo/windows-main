@echo off
echo restoring brave "Default" profile from desktop backup...
pause

set "SOURCE=%USERPROFILE%\Desktop\backup\browsers\brave\Default"

set "DEST=%LOCALAPPDATA%\BraveSoftware\Brave-Browser\User Data\Default"

echo restoring default profile...
xcopy "%SOURCE%" "%DEST%" /E /I /Y /H /C

echo.
echo brave profile has been successfully replaced in your localAppData folder
pause
