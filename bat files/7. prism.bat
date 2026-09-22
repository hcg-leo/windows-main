@echo off
title prism launcher backup restore
echo restoring prism launcher files from desktop backup
echo.

set "SOURCE=%USERPROFILE%\Desktop\backup\minecraft\prism launcher"
set "DEST=%APPDATA%\PrismLauncher"

xcopy "%SOURCE%\catpacks\*" "%DEST%\catpacks\" /E /I /Y /H

xcopy "%SOURCE%\iconthemes\*" "%DEST%\iconthemes\" /E /I /Y /H

xcopy "%SOURCE%\instances\*" "%DEST%\instances\" /E /I /Y /H

xcopy "%SOURCE%\themes\*" "%DEST%\themes\" /E /I /Y /H

copy /Y "%SOURCE%\prismlauncher.cfg" "%DEST%\"

echo.
echo done
pause