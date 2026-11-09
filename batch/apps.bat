@echo off

:: onenote (microsoft store)
winget install --id XPFFZHVGQWWLHB --silent --accept-package-agreements --accept-source-agreements --force --disable-interactivity --source msstore

for %%a in (
    ImputNet.Helium
    Hibbiki.Chromium
    Git.Git
    Python.Python.3.14
    Rustlang.Rustup
    ZedIndustries.Zed
    PrismLauncher.PrismLauncher
    Obsidian.Obsidian
    shinchiro.mpv
    LocalSend.LocalSend
    AutoHotkey.AutoHotkey
    Proton.ProtonVPN
    Proton.ProtonDrive
    AltSnap.AltSnap
    jurplel.qView
    flxzt.rnote
    7zip.7zip
    calibre.calibre
    oo-software.shutup10
    yt-dlp.yt-dlp
) do winget install --id=%%a -e

:: full path, winget's links folder isn't on PATH until a new terminal is opened
"%LOCALAPPDATA%\Microsoft\WinGet\Links\shutup10.exe"
pause
