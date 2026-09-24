@echo off
set "SOURCE=%USERPROFILE%\Desktop\backup\minecraft\prism launcher"
set "DEST=%APPDATA%\PrismLauncher"
xcopy "%SOURCE%\catpacks\*" "%DEST%\catpacks\" /E /I /Y /H
xcopy "%SOURCE%\iconthemes\*" "%DEST%\iconthemes\" /E /I /Y /H
xcopy "%SOURCE%\instances\*" "%DEST%\instances\" /E /I /Y /H
xcopy "%SOURCE%\themes\*" "%DEST%\themes\" /E /I /Y /H
copy /Y "%SOURCE%\prismlauncher.cfg" "%DEST%\"
pause