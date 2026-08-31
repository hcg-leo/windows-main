@echo off
echo pinning the rubbish bin to quick access

powershell -NoProfile -Command "((New-Object -ComObject shell.application).Namespace('shell:::{645FF040-5081-101B-9F08-00AA002F954E}').Self).InvokeVerb('pintohome')"

echo done
pause