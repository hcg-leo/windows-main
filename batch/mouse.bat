@echo off
powershell -c "$w=Add-Type -MemberDefinition '[DllImport(\"user32.dll\")]public static extern bool SystemParametersInfo(uint a,uint b,uint c,uint d);' -Name U -Namespace W -PassThru;$w::SystemParametersInfo(113,0,4,3)"
