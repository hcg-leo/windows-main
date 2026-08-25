param([switch]$RunCtt)

$ErrorActionPreference = 'Stop'
$backupRoot = Join-Path $env:USERPROFILE 'Desktop\backup'

function Step($text) { Write-Host ''; Write-Host "==> $text" -ForegroundColor Cyan }
function IsAdmin {
  $p = [Security.Principal.WindowsPrincipal]::new([Security.Principal.WindowsIdentity]::GetCurrent())
  $p.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
}
function SetMouseSpeed {
  $api = '[DllImport("user32.dll")] public static extern bool SystemParametersInfo(uint uiAction, uint uiParam, uint pvParam, uint fWinIni);'
  $user32 = Add-Type -MemberDefinition $api -Name User32 -Namespace Win32 -PassThru
  [void]$user32::SystemParametersInfo(0x0071, 0, 4, 3)
}
function SetWallpaper {
  $path = Join-Path $backupRoot 'wallpapers\- nord_mountains.png'
  if (-not (Test-Path -LiteralPath $path)) { throw "Wallpaper not found: $path" }
  $api = '[DllImport("user32.dll", CharSet = CharSet.Auto)] public static extern int SystemParametersInfo(int uAction, int uParam, string lpvParam, int fuWinIni);'
  Add-Type -MemberDefinition $api -Name Wallpaper -Namespace Win32
  [void][Win32.Wallpaper]::SystemParametersInfo(20, 0, $path, 3)
}
function RestoreFiles {
  Step 'Restoring Brave profile'
  $src = Join-Path $backupRoot 'browsers\brave\Default'; $dst = Join-Path $env:LOCALAPPDATA 'BraveSoftware\Brave-Browser\User Data\Default'
  Copy-Item (Join-Path $src '*') $dst -Recurse -Force
  Step 'Restoring Prism Launcher files'
  $src = Join-Path $backupRoot 'minecraft\prism launcher'; $dst = Join-Path $env:APPDATA 'PrismLauncher'
  foreach ($folder in 'catpacks', 'iconthemes', 'instances', 'themes') { Copy-Item (Join-Path $src "$folder\*") (Join-Path $dst $folder) -Recurse -Force }
  Copy-Item (Join-Path $src 'prismlauncher.cfg') $dst -Force
  Step 'Restoring Notepad++ settings'
  $src = Join-Path $backupRoot 'notepad++'; $dst = Join-Path $env:APPDATA 'Notepad++'
  New-Item -ItemType Directory $dst -Force | Out-Null
  Copy-Item (Join-Path $src 'config.xml') $dst -Force
  Copy-Item (Join-Path $src 'stylers.xml') $dst -Force
}
function InstallExtensions { foreach ($extension in 'arcticicestudio.nord-visual-studio-code', 'vscodevim.vim', 'esbenp.prettier-vscode') { & codium --install-extension $extension } }
function AddGitBashProfile {
  $file = Join-Path $env:LOCALAPPDATA 'Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json'
  if (-not (Test-Path $file)) { Write-Warning 'Windows Terminal settings not found; skipping Git Bash profile.'; return }
  $settings = Get-Content $file -Raw | ConvertFrom-Json
  if ($settings.profiles.list | Where-Object { $_.name -match 'Git Bash' }) { Write-Host 'Git Bash profile already exists.'; return }
  $settings.profiles.list += [PSCustomObject]@{ guid='{2ece5bfe-50ed-5f3a-ab87-5cd4baafed2b}'; hidden=$false; name='Git Bash'; commandline='C:\Program Files\Git\bin\bash.exe -i -l'; icon='C:\Program Files\Git\mingw64\share\git\git-for-windows.ico'; startingDirectory='%USERPROFILE%' }
  $settings | ConvertTo-Json -Depth 20 | Set-Content $file -Encoding UTF8
}

Write-Host 'Starting Windows setup...' -ForegroundColor Green
$admin = IsAdmin
if (-not $admin) { Write-Warning 'Not Administrator: driver installation and renaming will be skipped.' }
Step 'Setting mouse speed'; SetMouseSpeed
Step 'Setting wallpaper'; SetWallpaper
RestoreFiles
Step 'Installing VSCodium extensions'; InstallExtensions
Step 'Adding Git Bash Windows Terminal profile'; AddGitBashProfile
Step 'Opening Windows settings pages'
foreach ($page in 'ms-settings:display-advanced', 'ms-settings:nightlight', 'ms-settings:devices-touchpad', 'ms-settings:lockscreen') { Start-Process $page }
if ($admin) {
  Step 'Installing Samsung drivers'
  Push-Location (Join-Path $backupRoot 'samsung driver\driver pack')
  try { & pnputil.exe /add-driver '*.inf' /subdirs /install } finally { Pop-Location }
  Step 'Renaming computer to main'; Rename-Computer -NewName 'main'
}

# Change this before running. Do not commit a real Wi-Fi password.
$wifiName = 'EE-86FXKW'; $wifiPassword = 'password'
if ($wifiPassword -ne 'password') {
  Step "Connecting to Wi-Fi: $wifiName"
  $profilePath = Join-Path $env:TEMP 'temp_wifi_profile.xml'
  $xml = "<?xml version=""1.0""?><WLANProfile xmlns=""http://www.microsoft.com/networking/WLAN/profile/v1""><name>$wifiName</name><SSIDConfig><SSID><name>$wifiName</name></SSID></SSIDConfig><connectionType>ESS</connectionType><connectionMode>auto</connectionMode><MSM><security><authEncryption><authentication>WPA2PSK</authentication><encryption>AES</encryption></authEncryption><sharedKey><keyType>passPhrase</keyType><protected>false</protected><keyMaterial>$wifiPassword</keyMaterial></sharedKey></security></MSM></WLANProfile>"
  try { Set-Content $profilePath $xml -Encoding UTF8; & netsh.exe wlan add profile "filename=$profilePath"; & netsh.exe wlan connect "name=$wifiName" } finally { Remove-Item $profilePath -Force -ErrorAction SilentlyContinue }
} else { Write-Warning 'Wi-Fi skipped: replace the placeholder password in setup.ps1 first.' }
if ($RunCtt) { Step 'Running Chris Titus Tech utility'; Invoke-RestMethod 'https://christitus.com/win' | Invoke-Expression } else { Write-Host 'CTT skipped. Run with -RunCtt to opt in.' }
Write-Host ''; Write-Host 'Setup complete. Restart Windows to apply the computer-name change.' -ForegroundColor Green
