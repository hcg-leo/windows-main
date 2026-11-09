@echo off

:: mouse speed 4/20
powershell -c "$w=Add-Type -MemberDefinition '[DllImport(\"user32.dll\")]public static extern bool SystemParametersInfo(uint a,uint b,uint c,uint d);' -Name U -Namespace W -PassThru;$w::SystemParametersInfo(113,0,4,3)"

:: settings is one window, so open each page after the last one is done
for %%p in (bluetooth display-advanced lockscreen nightlight pen devices-touchpad) do (
    start ms-settings:%%p
    pause
)
