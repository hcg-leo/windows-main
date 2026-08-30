@echo off
:: Replace these with your actual Wi-Fi name (SSID) and password
set "WIFI_NAME=EE-86FXKW"
set "WIFI_PASSWORD=password"

echo Setting up Wi-Fi profile for %WIFI_NAME%...

:: 1. Generate the required XML configuration file
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

:: 2. Import the profile into Windows
netsh wlan add profile filename="temp_wifi_profile.xml"

:: 3. Connect to the network
echo Connecting to %WIFI_NAME%...
netsh wlan connect name="%WIFI_NAME%"

:: 4. Clean up the temporary XML file
del temp_wifi_profile.xml

echo.
echo Process complete. 
pause