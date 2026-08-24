@echo off
:: replace password ect
set "WIFI_NAME=EE-86FXKW"
set "WIFI_PASSWORD=password"

echo setting up Wi-Fi profile for %WIFI_NAME%...

(
echo ^<?xml version="1.0"?^>
echo ^<WLANProfile xmlns="http://www.microsoft.com/networking/WLAN/profile/v1"^>
echo     ^<name^>%WIFI_NAME%^</name^>
echo     ^<SSIDConfig^>
echo         ^<SSID^>
echo             ^<name^>%WIFI_NAME%^</name^>
echo         ^</SSID^>
echo     ^</SSIDConfig^>
echo     ^<connectionType^>ESS^</connectionType^>
echo     ^<connectionMode^>auto^</connectionMode^>
echo     ^<MSM^>
echo         ^<security^>
echo             ^<authEncryption^>
echo                 ^<authentication^>WPA2PSK^</authentication^>
echo                 ^<encryption^>AES^</encryption^>
echo             ^</authEncryption^>
echo             ^<sharedKey^>
echo                 ^<keyType^>passPhrase^</keyType^>
echo                 ^<protected^>false^</protected^>
echo                 ^<keyMaterial^>%WIFI_PASSWORD%^</keyMaterial^>
echo             ^</sharedKey^>
echo         ^</security^>
echo     ^</MSM^>
echo ^</WLANProfile^>
) > temp_wifi_profile.xml

netsh wlan add profile filename="temp_wifi_profile.xml"

echo Connecting to %WIFI_NAME%...
netsh wlan connect name="%WIFI_NAME%"

del temp_wifi_profile.xml

echo.
echo Process complete. 
pause