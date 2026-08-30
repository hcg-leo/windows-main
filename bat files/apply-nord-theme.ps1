<#
    apply-nord-theme.ps1
    ---------------------
    Configures Notepad++ to:
      1) use the Nord theme for the editor (downloads it if not present)
      2) hide the toolbar
      3) apply Nord colors to the "bars" too - menu bar, toolbar,
         tab bar and dialog backgrounds - via Notepad++'s Dark Mode
         "Customized" tone, instead of the generic default dark gray.

    Handles two cases:
      A) config.xml does not exist yet -> creates a minimal one.
         Notepad++ fills in every other setting with its built-in
         defaults the next time it writes config.xml on exit.
      B) config.xml already exists -> backs it up, then edits it in place.

    Also detects "Local Conf" / portable installs (a zero-byte file
    called doLocalConf.xml sitting next to notepad++.exe), in which
    case settings live in the install folder instead of %APPDATA%.

    NOTE on the Dark Mode colors below: Notepad++ stores Dark Mode
    colors as decimal Windows COLORREF values (R + G*256 + B*65536),
    not hex. The values here are that formula applied to the official
    Nord palette hex codes (background 2E3440, panel 3B4252, tab/hover
    434C5E, border/disabled 4C566A, text D8DEE9, muted text 616E88,
    link/accent 88C0D0, hot edge 81A1C1, error BF616A), cross-
    checked against a working community reference (the Catppuccin
    Notepad++ theme's config, which uses the same encoding) so the
    arithmetic is verified. What is NOT independently verified is
    whether every one of these DarkMode attribute names exists in
    your exact Notepad++ build - they were confirmed present as of
    v8.7.1 (Nov 2024); on a much older version some may simply be
    ignored rather than cause an error, per Notepad++'s own tolerant
    config parsing, but that's an inference, not something I've tested
    on your machine.
#>

$ErrorActionPreference = 'Stop'

function Write-Info { param($msg) Write-Host $msg }
function Write-Err  { param($msg) Write-Host $msg -ForegroundColor Red }

# 1. Try to find the Notepad++ install folder
$nppDir = $null
foreach ($candidate in @("$Env:ProgramFiles\Notepad++", "${Env:ProgramFiles(x86)}\Notepad++")) {
    if ($candidate -and (Test-Path (Join-Path $candidate 'notepad++.exe'))) {
        $nppDir = $candidate
        break
    }
}
if (-not $nppDir) {
    Write-Info "Could not find notepad++.exe under Program Files - assuming a standard (non-portable) install."
}

# 2. Work out which folder Notepad++ actually reads/writes its config from
$configDir = Join-Path $Env:APPDATA 'Notepad++'
if ($nppDir -and (Test-Path (Join-Path $nppDir 'doLocalConf.xml'))) {
    $configDir = $nppDir
    Write-Info "doLocalConf.xml found next to notepad++.exe -> Notepad++ is in Local/Portable Conf mode."
    Write-Info "Using '$configDir' instead of %APPDATA%."
}
Write-Info "Config folder: $configDir"

# 3. Make sure the folder (and its themes subfolder) exist
foreach ($dir in @($configDir, (Join-Path $configDir 'themes'))) {
    if (-not (Test-Path $dir)) {
        try {
            New-Item -ItemType Directory -Path $dir -Force | Out-Null
            Write-Info "Created folder: $dir"
        } catch {
            Write-Err "Could not create '$dir': $_"
            Write-Err "Check that your Windows account has write permission here, and that you are not running this script (or Notepad++) 'as Administrator' while logged in as a normal user - mismatched elevation is a common reason config.xml never gets created."
            exit 1
        }
    }
}

# 4. Download the Nord theme stylers file if it isn't already there
$themePath = Join-Path $configDir 'themes\nord.xml'
if (-not (Test-Path $themePath)) {
    Write-Info "Downloading Nord theme from github.com/nordtheme/notepadplusplus ..."
    $themeUrl = 'https://raw.githubusercontent.com/nordtheme/notepadplusplus/develop/src/xml/nord.xml'
    try {
        Invoke-WebRequest -Uri $themeUrl -OutFile $themePath -UseBasicParsing
    } catch {
        Write-Err "Download failed: $_"
        Write-Err "Check your internet connection / proxy settings, then re-run this script."
        exit 1
    }
} else {
    Write-Info "Nord theme file already present at '$themePath' - not re-downloading."
}

# 5. Create or edit config.xml
$configPath = Join-Path $configDir 'config.xml'

if (Test-Path $configPath) {
    Write-Info "Existing config.xml found - backing it up and editing in place."
    $backupPath = "$configPath.bak-$(Get-Date -Format yyyyMMdd-HHmmss)"
    Copy-Item -Path $configPath -Destination $backupPath -Force
    Write-Info "Backup saved to: $backupPath"

    try {
        [xml]$xml = Get-Content -Path $configPath -Raw

        $guiConfigs = $xml.NotepadPlus.GUIConfigs
        if (-not $guiConfigs) {
            $guiConfigs = $xml.CreateElement('GUIConfigs')
            $xml.NotepadPlus.AppendChild($guiConfigs) | Out-Null
        }

        $toolBar = $guiConfigs.GUIConfig | Where-Object { $_.name -eq 'ToolBar' }
        if (-not $toolBar) {
            $toolBar = $xml.CreateElement('GUIConfig')
            $toolBar.SetAttribute('name', 'ToolBar')
            $guiConfigs.AppendChild($toolBar) | Out-Null
        }
        $toolBar.InnerText = 'hide'
        if ($toolBar.Attributes['visible']) { $toolBar.SetAttribute('visible', 'no') }

        $stylerTheme = $guiConfigs.GUIConfig | Where-Object { $_.name -eq 'stylerTheme' }
        if (-not $stylerTheme) {
            $stylerTheme = $xml.CreateElement('GUIConfig')
            $stylerTheme.SetAttribute('name', 'stylerTheme')
            $guiConfigs.AppendChild($stylerTheme) | Out-Null
        }
        $stylerTheme.SetAttribute('path', $themePath)

        $darkMode = $guiConfigs.GUIConfig | Where-Object { $_.name -eq 'DarkMode' }
        if (-not $darkMode) {
            $darkMode = $xml.CreateElement('GUIConfig')
            $darkMode.SetAttribute('name', 'DarkMode')
            $guiConfigs.AppendChild($darkMode) | Out-Null
        }
        # Nord hex -> Windows COLORREF decimal (R + G*256 + B*65536)
        $nordDarkModeAttrs = @{
            enable                  = 'yes'
            colorTone               = '32'        # "Customized" tone (community-verified value, not first-party documented)
            customColorTop          = '4207662'    # 2E3440 - menu bar / toolbar background
            customColorMenuHotTrack = '6179907'    # 434C5E - hovered/active menu entry
            customColorActive       = '6179907'    # 434C5E - active tab
            customColorMain         = '5390907'    # 3B4252 - inactive tabs + most dialog backgrounds
            customColorError        = '6971839'    # BF616A - error/invalid field background
            customColorText         = '15326936'   # D8DEE9 - normal text
            customColorDarkText     = '8941153'    # 616E88 - muted/secondary text
            customColorDisabledText = '6968908'    # 4C566A - disabled text
            customColorLinkText     = '13680776'   # 88C0D0 - links/accents
            customColorEdge         = '6968908'    # 4C566A - borders
            customColorHotEdge      = '12689793'   # 81A1C1 - hovered border
            customColorDisabledEdge = '6968908'    # 4C566A - disabled border
            darkThemeName           = 'nord.xml'   # tab colors follow this theme's own tab styles when darkTabUseTheme=yes
            darkTabUseTheme         = 'yes'
            lightThemeName          = 'nord.xml'
            lightTabUseTheme        = 'yes'
        }
        foreach ($attr in $nordDarkModeAttrs.GetEnumerator()) {
            $darkMode.SetAttribute($attr.Key, $attr.Value)
        }

        $xml.Save($configPath)
    } catch {
        Write-Err "Could not parse/edit the existing config.xml: $_"
        Write-Err "The file may be corrupted. A backup was saved to '$backupPath'."
        Write-Err "You can delete the original config.xml and re-run this script to generate a fresh one."
        exit 1
    }
} else {
    Write-Info "No config.xml found at '$configPath' - creating a new one."
    $newXml = @"
<?xml version="1.0" encoding="Windows-1252" ?>
<NotepadPlus>
    <GUIConfigs>
        <GUIConfig name="ToolBar" visible="no">hide</GUIConfig>
        <GUIConfig name="stylerTheme" path="$themePath" />
        <GUIConfig name="DarkMode" enable="yes" colorTone="32" customColorTop="4207662" customColorMenuHotTrack="6179907" customColorActive="6179907" customColorMain="5390907" customColorError="6971839" customColorText="15326936" customColorDarkText="8941153" customColorDisabledText="6968908" customColorLinkText="13680776" customColorEdge="6968908" customColorHotEdge="12689793" customColorDisabledEdge="6968908" darkThemeName="nord.xml" darkTabUseTheme="yes" lightThemeName="nord.xml" lightTabUseTheme="yes" />
    </GUIConfigs>
</NotepadPlus>
"@
    Set-Content -Path $configPath -Value $newXml -Encoding UTF8
}

Write-Host ""
Write-Host "Done." -ForegroundColor Green
Write-Host "Toolbar   -> hide"
Write-Host "Theme     -> $themePath"
Write-Host "Dark Mode -> enabled, Nord-colored (menu bar, toolbar, tabs, dialogs)"
Write-Host ""
Write-Host "IMPORTANT: Notepad++ only WRITES config.xml when it fully exits."
Write-Host "If Notepad++ is currently running, close every open window first"
Write-Host "(check Task Manager for a lingering notepad++.exe process),"
Write-Host "otherwise it will overwrite what this script just did. Then start"
Write-Host "Notepad++ again. If the menu/toolbar don't look fully updated,"
Write-Host "a full restart (not just close/reopen a document) picks up Dark"
Write-Host "Mode completely - this is Notepad++'s own documented behavior."
