@echo off
set "SOURCE=%USERPROFILE%\Desktop\backup\browsers\brave\Default"
set "DEST=%LOCALAPPDATA%\BraveSoftware\Brave-Browser\User Data\Default"
xcopy "%SOURCE%" "%DEST%" /E /I /Y /H /C
pause
