@echo off
echo restoring notepad++ settings...

set "SOURCE_DIR=%USERPROFILE%\Desktop\backup\notepad++"
set "DEST_DIR=%appdata%\Notepad++"

if not exist "%DEST_DIR%" (
    mkdir "%DEST_DIR%"
)

copy /Y "%SOURCE_DIR%\config.xml" "%DEST_DIR%\"
copy /Y "%SOURCE_DIR%\stylers.xml" "%DEST_DIR%\"

echo.
echo motepad++ settings transferred successfully
pause