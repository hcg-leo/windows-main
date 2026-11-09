@echo off
cd /d "%~dp0.."

robocopy altsnap "%APPDATA%\AltSnap" /e
robocopy terminal "%LOCALAPPDATA%\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState" /e
robocopy zed "%APPDATA%\Zed" /e
if exist prism robocopy prism "%APPDATA%\PrismLauncher" /e
if exist localsend robocopy localsend "%APPDATA%\LocalSend" /e

:: start wm.ahk and altsnap on login
set "startup=%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup"
powershell -c "$l = (New-Object -ComObject WScript.Shell).CreateShortcut('%startup%\wm.lnk'); $l.TargetPath = '%cd%\ahk\wm.ahk'; $l.Save()"
powershell -c "$l = (New-Object -ComObject WScript.Shell).CreateShortcut('%startup%\AltSnap.lnk'); $l.TargetPath = '%APPDATA%\AltSnap\AltSnap.exe'; $l.Save()"
pause
