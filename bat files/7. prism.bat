@echo off
title Prism Launcher Backup Restore
echo Restoring Prism Launcher files from Desktop backup...
echo.

set "SOURCE=%USERPROFILE%\Desktop\backup\minecraft\prism launcher"
set "DEST=%APPDATA%\PrismLauncher"

echo Restoring catpacks...
xcopy "%SOURCE%\catpacks\*" "%DEST%\catpacks\" /E /I /Y /H

echo Restoring iconthemes...
xcopy "%SOURCE%\iconthemes\*" "%DEST%\iconthemes\" /E /I /Y /H

echo Restoring instances...
xcopy "%SOURCE%\instances\*" "%DEST%\instances\" /E /I /Y /H

echo Restoring themes...
xcopy "%SOURCE%\themes\*" "%DEST%\themes\" /E /I /Y /H

echo Restoring config file...
copy /Y "%SOURCE%\prismlauncher.cfg" "%DEST%\"

echo.
echo All files and folders have been successfully replaced in your AppData folder!
pause