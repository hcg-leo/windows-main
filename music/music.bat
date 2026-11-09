@echo off
cd /d "%~dp0"
set /p "url=url: "
set /p "playlist=playlist: "
yt-dlp -x --audio-format mp3 -o "%playlist%\%%(title)s.%%(ext)s" "%url%"
pause
