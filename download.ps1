# Download and install portmaster-installer.exe
Invoke-WebRequest -Uri "https://updates.safing.io/latest/windows_amd64/packages/portmaster-installer.exe" -OutFile "$env:USERPROFILE\Downloads\portmaster-installer.exe"

# Download and install Windscribe_2.6.14.exe
Invoke-WebRequest -Uri "https://windscribe.com/install/desktop/windows/Windscribe_2.6.14.exe" -OutFile "$env:USERPROFILE\Downloads\Windscribe_2.6.14.exe"

# Download and install BraveBrowserSetup.exe
Invoke-WebRequest -Uri "https://laptop-updates.brave.com/latest/winx64/BraveBrowserSetup.exe" -OutFile "$env:USERPROFILE\Downloads\BraveBrowserSetup.exe"

# Download and install Spice Guest Tools
Invoke-WebRequest -Uri "https://www.spice-space.org/download/windows/spice-guest-tools/spice-guest-tools-latest.exe" -OutFile "$env:USERPROFILE\Downloads\spice-guest-tools-latest.exe"

# Download and install Spice WebDAVd
Invoke-WebRequest -Uri "https://www.spice-space.org/download/windows/spice-webdavd/spice-webdavd-x64-latest.msi" -OutFile "$env:USERPROFILE\Downloads\spice-webdavd-x64-latest.msi"

# Run the script from christitus.com
Invoke-Expression (Invoke-WebRequest -Uri "https://christitus.com/win").Content
