@echo off
:: set the speed here
set "SPEED=4"

echo changing mouse speed to %SPEED%...

powershell -NoProfile -ExecutionPolicy Bypass -Command "$API = '[DllImport(\"user32.dll\")] public static extern bool SystemParametersInfo(uint uiAction, uint uiParam, uint pvParam, uint fWinIni);'; $Win32 = Add-Type -MemberDefinition $API -Name 'User32' -Namespace 'Win32' -PassThru; $Win32::SystemParametersInfo(0x0071, 0, %SPEED%, 3)"

echo mouse speed successfully updated
timeout /t 2 >nul
