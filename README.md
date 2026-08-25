# windows debloat setup

*embrace windows.*

![windows](https://img.shields.io/badge/windows-0078d6?style=for-the-badge&logo=windows11) ![batch](https://img.shields.io/badge/batch-4d4d4d?style=for-the-badge) ![powershell](https://img.shields.io/badge/powershell-5391fe?style=for-the-badge&logo=powershell)

Personal setup used to debloat and configure Windows after a fresh install on a Galaxy Book 3 360. This repository is also a backup folder: each directory mirrors where its settings normally live, and `setup.ps1` restores and configures them.

### overview

```
.
├── bat files
│   ├── 1. mouse-speed.bat
│   ├── 2. samsung drivers.bat
│   ├── 3. host-name.bat
│   ├── 4. wifi.bat
│   ├── 5. ctt.bat
│   ├── 6. brave.bat
│   ├── 7. prism.bat
│   ├── 8. notepad++.bat
│   ├── 9. wallpaper.bat
│   ├── 10. display.bat
│   ├── 11. night-light.bat
│   ├── 12. touchpad.bat
│   ├── 13. lockscreen.bat
│   ├── 14. vscodium-extensions.bat
│   └── 15. git-powershell.bat
├── browsers
│   └── brave
│       └── settings.txt
├── minecraft
│   └── prism launcher
│       ├── catpacks
│       ├── iconthemes
│       ├── instances
│       ├── themes
│       └── prismlauncher.cfg
├── samsung drivers
│   └── driver pack
├── tweaks
│   ├── - tweaks.json
│   ├── - tweaks.winhance
│   ├── school.json
│   ├── school.winhance
│   └── autounattend.xml
├── wallpapers
│   ├── - nord_mountains.png
│   └── - palette_blue_dark.jpg
├── setup.ps1
└── winhance
```

> note: most of these folders only hold a `desktop.ini` for the folder icon right now, drop your own backup files into them before running the scripts

## install bat

clone this straight into the backup folder on the desktop

```
cd %userprofile%\desktop
```

```
git clone https://github.com/hcg-leo/windows-main backup
```

open `bat files/4. wifi.bat` and swap in your own network name and password, theres a comment at the top showing where

open `bat files/1. mouse-speed.bat` first if you want a different pointer speed than the default

then run each script in `bat files/` in order, `1. mouse-speed.bat` through to `15. git-powershell.bat`

## install .ps1 script

```powershell
Set-Location $env:USERPROFILE\Desktop
git clone https://github.com/hcg-leo/windows-main backup
Set-Location .\backup
```

Before running, open `setup.ps1` and replace the placeholder value for `$wifiPassword`. Do not commit a real password to Git.

Run PowerShell as **Administrator**, then run:

```powershell
.\setup.ps1
```

If Windows blocks local scripts, use this one-time command:

```powershell
powershell -ExecutionPolicy Bypass -File .\setup.ps1
```

The optional Chris Titus Tech utility downloads and executes a remote script, so it is disabled by default. Opt in only if you intend to run it:

```powershell
.\setup.ps1 -RunCtt
```

## the files and what they hold

- `setup.ps1`: all-in-one PowerShell setup script.
- `bat files/`: the original numbered batch files; use these only when you want to run a single action manually.
- `browsers/brave/settings.txt`: Brave flags and sync options to enable manually.
- `minecraft/prism launcher/`: catpacks, icon themes, instances, themes, and `prismlauncher.cfg`.
- `samsung drivers/driver pack/`: Samsung driver pack for the Galaxy Book 3 360.
- `tweaks/`: Winhance profiles and `autounattend.xml`.
- `wallpapers/`: wallpapers; `- nord_mountains.png` is applied by the setup script.
- `winhance/`: place the Winhance app here before importing profiles from `tweaks/`.

## credits

- [Chris Titus Tech's Windows Utility](https://github.com/ChrisTitusTech/winutil)
- [Winhance](https://github.com/memstechtips/Winhance)
