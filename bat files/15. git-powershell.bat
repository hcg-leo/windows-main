@echo off

set "SETTINGS_FILE=%LOCALAPPDATA%\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json"

if not exist "%SETTINGS_FILE%" (
    echo Windows Terminal settings file not found!
    echo Please ensure Windows Terminal is installed and has been run at least once.
    pause
    exit /b
)

echo checking windows terminal settings...

powershell -NoProfile -Command "$path = '%SETTINGS_FILE%'; $json = Get-Content -Raw -Path $path | ConvertFrom-Json; $exists = $false; foreach ($p in $json.profiles.list) { if ($p.name -match 'Git Bash') { $exists = $true; break; } }; if (-not $exists) { $gitProfile = [PSCustomObject]@{ guid = '{2ece5bfe-50ed-5f3a-ab87-5cd4baafed2b}'; hidden = $false; name = 'Git Bash'; commandline = 'C:\Program Files\Git\bin\bash.exe -i -l'; icon = 'C:\Program Files\Git\mingw64\share\git\git-for-windows.ico'; startingDirectory = '%%USERPROFILE%%' }; $json.profiles.list += $gitProfile; $json | ConvertTo-Json -Depth 20 | Out-File -FilePath $path -Encoding utf8; Write-Host 'Git Bash successfully added to the dropdown menu!' -ForegroundColor Green } else { Write-Host 'Git Bash is already in your Terminal profiles.' -ForegroundColor Yellow }"

echo.
pause