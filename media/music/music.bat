@echo off
set /p url=url:
set /p folder=playlist:
set "dest=C:\Users\Aran Thananjayan\Desktop\windows-main\media\music\%folder%"
if not exist "%dest%" mkdir "%dest%"
spotdl download "%url%" --output "%dest%\{artists} - {title}.{output-ext}"
pause
