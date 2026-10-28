@echo off
set /p "url=url: "
set /p "playlist=playlist: "
if not exist "C:\Users\Aran Thananjayan\Desktop\windows-main\media\music\%playlist%" mkdir "C:\Users\Aran Thananjayan\Desktop\windows-main\media\music\%playlist%"
yt-dlp -x --audio-format mp3 -o "C:\Users\Aran Thananjayan\Desktop\windows-main\media\music\%playlist%\%%(title)s.%%(ext)s" "%url%"
pause
