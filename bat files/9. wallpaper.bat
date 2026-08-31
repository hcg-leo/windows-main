@echo off
echo setting desktop wallpaper

set "WALLPAPER_PATH=%USERPROFILE%\Desktop\backup\wallpapers\- nord_mountains.png"

powershell -NoProfile -ExecutionPolicy Bypass -Command "$code = '[DllImport(\"user32.dll\", CharSet=CharSet.Auto)] public static extern int SystemParametersInfo(int uAction, int uParam, string lpvParam, int fuWinIni);'; $type = Add-Type -MemberDefinition $code -Name Win32 -Namespace System -OutputAssembly $null; [System.Win32]::SystemParametersInfo(20, 0, '%WALLPAPER_PATH%', 3)"

echo.
echo done
pause
