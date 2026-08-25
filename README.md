# windows debloat setup

*embrace debloat.*

![windows](https://img.shields.io/badge/windows-0078d6?style=for-the-badge&logo=windows11) ![batch](https://img.shields.io/badge/batch-4d4d4d?style=for-the-badge) ![powershell](https://img.shields.io/badge/powershell-5391fe?style=for-the-badge&logo=powershell)

personal setup used to debloat and configure windows after a fresh install on my galaxy book 3 360. this repo is basically a backup folder - each directory mirrors somewhere your settings normally live, and the scripts in `bat files/` copy everything back into place.

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
└── winhance
```

> note: most of these folders only hold a `desktop.ini` for the folder icon right now, drop your own backup files into them before running the scripts

### the files and what they hold

- `bat files/`: numbered scripts, run top to bottom on a fresh install to put everything below back in place
- `browsers/brave/settings.txt`: brave://flags and sync options to turn on by hand, not scripted
- `minecraft/prism launcher/`: catpacks, iconthemes, instances, themes and `prismlauncher.cfg`, restored by `7. prism.bat`
- `samsung drivers/driver pack/`: samsung driver pack for the galaxy book 3 360, installed by `2. samsung drivers.bat`
- `tweaks/`: winhance tweak profiles (`- tweaks` and `school`) plus `autounattend.xml`, the answer file for an unattended windows install
- `wallpapers/`: wallpapers, `- nord_mountains.png` is the one set automatically by `9. wallpaper.bat`
- `winhance/`: empty, drop the winhance app here before importing the profiles in `tweaks/`

### install

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

### what each script does

- `1. mouse-speed.bat`: sets the mouse pointer speed
- `2. samsung drivers.bat`: installs the driver pack with `pnputil`
- `3. host-name.bat`: renames the pc to `main`
- `4. wifi.bat`: adds and connects to a wifi profile
- `5. ctt.bat`: runs chris titus tech's windows utility
- `6. brave.bat`: restores the brave default profile from the backup folder
- `7. prism.bat`: restores prism launcher's catpacks, iconthemes, instances, themes and config
- `8. notepad++.bat`: restores notepad++'s config and stylers files
- `9. wallpaper.bat`: sets the desktop wallpaper
- `10. display.bat`: opens advanced display settings
- `11. night-light.bat`: opens night light settings
- `12. touchpad.bat`: opens touchpad settings
- `13. lockscreen.bat`: opens lock screen settings
- `14. vscodium-extensions.bat`: installs the nord theme, vim and prettier extensions for vscodium
- `15. git-powershell.bat`: adds a git bash profile to windows terminal

### credits

- [chris titus tech's windows utility](https://github.com/ChrisTitusTech/winutil)
- [winhance](https://github.com/memstechtips/Winhance)
