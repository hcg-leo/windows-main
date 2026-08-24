@echo off
echo restoring prism launcher files from desktop backup...
echo.

set "SOURCE=%USERPROFILE%\Desktop\backup\minecraft\prism launcher"
set "DEST=%APPDATA%\PrismLauncher"

echo restoring catpacks...
xcopy "%SOURCE%\catpacks\*" "%DEST%\catpacks\" /E /I /Y /H

echo restoring iconthemes...
xcopy "%SOURCE%\iconthemes\*" "%DEST%\iconthemes\" /E /I /Y /H

echo restoring instances...
xcopy "%SOURCE%\instances\*" "%DEST%\instances\" /E /I /Y /H

echo restoring themes...
xcopy "%SOURCE%\themes\*" "%DEST%\themes\" /E /I /Y /H

echo restoring config file...
copy /Y "%SOURCE%\prismlauncher.cfg" "%DEST%\"

echo.
echo all files and folders have been successfully replaced in your AppData folder
pause