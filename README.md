# windows debloat setup

*embrace windows.*

![windows](https://img.shields.io/badge/windows-0078d6?style=for-the-badge&logo=windows11) ![batch](https://img.shields.io/badge/batch-4d4d4d?style=for-the-badge) ![powershell](https://img.shields.io/badge/powershell-5391fe?style=for-the-badge&logo=powershell)

personal debloat + config backup for windows, built for a galaxy book 3 360. each folder mirrors where a setting normally lives, and `bat files/` copies it all back into place.

> most folders only hold a `desktop.ini` right now — drop your own backup files in before running the scripts

### structure

- `bat files/` - numbered scripts, run top to bottom on a fresh install
- `browsers/brave/settings.txt` - flags & sync options to set by hand
- `minecraft/prism launcher/` - restored by `7. prism.bat`
- `samsung drivers/driver pack/` - galaxy book 3 360 drivers, installed by `2. samsung drivers.bat`
- `tweaks/` - winhance profile + `autounattend.xml` + 'ctt profile'
- `wallpapers/` - `nord_mountains.png` is set automatically by `9. wallpaper.bat`
- `winhance/` - drop the app here before importing the tweak profiles

### install

```
cd %userprofile%\desktop
git clone https://github.com/hcg-leo/windows-main backup
```

edit `4. wifi.bat` with your network name/password, and `1. mouse-speed.bat` first if you want a different pointer speed. then run each script in `bat files/` in order, `1` through `15`.

### credits

- [chris titus tech's windows utility](https://github.com/ChrisTitusTech/winutil)
- [winhance](https://github.com/memstechtips/Winhance)
