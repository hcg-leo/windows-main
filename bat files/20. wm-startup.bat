```bat
@powershell -NoProfile -Command "$w=New-Object -ComObject WScript.Shell;$s=$w.CreateShortcut($env:APPDATA+'\Microsoft\Windows\Start Menu\Programs\Startup\shortcut.lnk');$s.TargetPath='C:\Users\Aran Thananjayan\Desktop\backup\bat files\shortcut.ahk';$s.WorkingDirectory='C:\Users\Aran Thananjayan\Desktop\backup\bat files';$s.Save()"
```
