@echo off
set /p "name=manga name: "
set /p "url=url: "
:: source: https://github.com/Girbons/comics-downloader
.\comics-downloader-win-x86-64.exe -format=epub -custom-comic-name="%name%" -url="%url%" -output="C:\Users\Aran Thananjayan\Desktop\windows-main\media\manga"
pause
