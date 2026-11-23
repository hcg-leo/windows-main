@echo off
set /p "playlist=playlist: "
:start
set "url="
set /p "url=url: "
if not defined url exit /b
yt-dlp -x --audio-format mp3 --embed-metadata --embed-thumbnail --convert-thumbnails jpg -o "C:\Users\Aran Thananjayan\Desktop\windows-main\media\music\%playlist%\%%(title)s.%%(ext)s" "%url%"
goto start
