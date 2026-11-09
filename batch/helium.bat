@echo off
set "helium=%LOCALAPPDATA%\imput\Helium\Application\chrome.exe"

for %%u in (
    https://chromewebstore.google.com/detail/proton-pass-free-password/ghmbeldphafepmbegfdlkpapadhbakde
    https://chromewebstore.google.com/detail/sponsorblock-for-youtube/mnjggcdmjocbbbhaepdhchncahnbgone
    https://chromewebstore.google.com/detail/consent-o-matic/mdjildafknihdffpkfmmpnpoiajfjnjd
    https://chromewebstore.google.com/detail/remove-youtube-shorts/mgngbgbhliflggkamjnpdmegbkidiapm
    https://chromewebstore.google.com/detail/popup-blocker-strict/aefkmifgmaafnojlojpnekbpbmjiiogg
    https://chromewebstore.google.com/detail/google-chrome-nord-theme/honjmojpikfebagfakclmgbcchedenbo
    https://chromewebstore.google.com/detail/picture-in-picture-extens/hkgfoiooedgoejojocmhlaklaeopbecg
    helium://flags/#import-export-flags
    helium://settings/appearance
    helium://settings/importData
) do start "" "%helium%" %%u
