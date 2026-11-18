@echo off
:start
set "url="
set "playlist="
set /p "url=url: "
if not defined url exit /b
set /p "playlist=playlist: "
if not exist "C:\Users\Aran Thananjayan\Desktop\windows-main\music\%playlist%" mkdir "C:\Users\Aran Thananjayan\Desktop\windows-main\music\%playlist%"
yt-dlp -x --audio-format mp3 --embed-metadata --embed-thumbnail --convert-thumbnails jpg -o "C:\Users\Aran Thananjayan\Desktop\windows-main\music\%playlist%\%%(title)s.%%(ext)s" "%url%"
echo.
goto start
