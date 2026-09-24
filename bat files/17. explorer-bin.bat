@echo off
powershell -NoProfile -Command "((New-Object -ComObject shell.application).Namespace('shell:::{645FF040-5081-101B-9F08-00AA002F954E}').Self).InvokeVerb('pintohome')"
pause