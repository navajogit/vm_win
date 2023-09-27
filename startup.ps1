# Download and install portmaster-installer.exe
Write-Host "Downloading portmaster-installer.exe..."
Invoke-WebRequest -Uri "https://updates.safing.io/latest/windows_amd64/packages/portmaster-installer.exe" -OutFile "$env:USERPROFILE\Downloads\portmaster-installer.exe"
if ($?) {
    Write-Host "portmaster-installer.exe downloaded successfully."
} else {
    Write-Host "Failed to download portmaster-installer.exe. Please try downloading it manually or run the script again."
    exit
}

# Add a delay between downloads
Start-Sleep -Seconds 2

# Download and install Windscribe_2.6.14.exe
Write-Host "Downloading Windscribe_2.6.14.exe..."
Invoke-WebRequest -Uri "https://windscribe.com/install/desktop/windows/Windscribe_2.6.14.exe" -OutFile "$env:USERPROFILE\Downloads\Windscribe_2.6.14.exe"
if ($?) {
    Write-Host "Windscribe_2.6.14.exe downloaded successfully."
} else {
    Write-Host "Failed to download Windscribe_2.6.14.exe. Please try downloading it manually or run the script again."
    exit
}

# Add a delay between downloads
Start-Sleep -Seconds 2

# Download and install BraveBrowserSetup.exe
Write-Host "Downloading BraveBrowserSetup.exe..."
Invoke-WebRequest -Uri "https://laptop-updates.brave.com/latest/winx64/BraveBrowserSetup.exe" -OutFile "$env:USERPROFILE\Downloads\BraveBrowserSetup.exe"
if ($?) {
    Write-Host "BraveBrowserSetup.exe downloaded successfully."
} else {
    Write-Host "Failed to download BraveBrowserSetup.exe. Please try downloading it manually or run the script again."
    exit
}

# Add a delay between downloads
Start-Sleep -Seconds 2

# Download and install Spice Guest Tools
Write-Host "Downloading spice-guest-tools-latest.exe..."
Invoke-WebRequest -Uri "https://www.spice-space.org/download/windows/spice-guest-tools/spice-guest-tools-latest.exe" -OutFile "$env:USERPROFILE\Downloads\spice-guest-tools-latest.exe"
if ($?) {
    Write-Host "spice-guest-tools-latest.exe downloaded successfully."
} else {
    Write-Host "Failed to download spice-guest-tools-latest.exe. Please try downloading it manually or run the script again."
    exit
}

# Add a delay between downloads
Start-Sleep -Seconds 2

# Download and install Spice WebDAVd
Write-Host "Downloading spice-webdavd-x64-latest.msi..."
Invoke-WebRequest -Uri "https://www.spice-space.org/download/windows/spice-webdavd/spice-webdavd-x64-latest.msi" -OutFile "$env:USERPROFILE\Downloads\spice-webdavd-x64-latest.msi"
if ($?) {
    Write-Host "spice-webdavd-x64-latest.msi downloaded successfully."
} else {
    Write-Host "Failed to download spice-webdavd-x64-latest.msi. Please try downloading it manually or run the script again."
    exit
}

# Prompt to run the program
$runProgram = Read-Host "Do you want to run the program from christitus.com? (Y/N)"
if ($runProgram -eq "Y" -or $runProgram -eq "y") {
    # Run the script from christitus.com
    Invoke-Expression (Invoke-WebRequest -Uri "https://christitus.com/win").Content
} else {
    Write-Host "The program was not executed."
}


# changing wallpaper

while ($true) {
    # Zapytaj użytkownika, czy chce zmienić tapetę
    $changeWallpaper = Read-Host "Do you want to change the desktop wallpaper? (Y/N)"
    if ($changeWallpaper -eq "Y" -or $changeWallpaper -eq "y") {
        # URL repozytorium GitHub zawierającego listę URL obrazków
        $githubRepoUrl = "https://raw.githubusercontent.com/navajogit/vm_win/main/wallpapers_urls.txt"

        # Pobierz zawartość pliku z listą URL obrazków
        $wallpaperUrls = Invoke-RestMethod -Uri $githubRepoUrl

        # Wybierz losowy URL z listy
        $randomUrl = $wallpaperUrls | Get-Random

        # Ścieżka docelowa dla tapety w folderze tapet systemowych
        $wallpaperPath = "$env:USERPROFILE\AppData\Roaming\Microsoft\Windows\Themes\TranscodedWallpaper"

        # Pobierz losowy obrazek za pomocą wget
        Invoke-WebRequest -Uri $randomUrl -OutFile $wallpaperPath

        # Ustaw obrazek jako tapetę
        Add-Type -TypeDefinition @"
        using System;
        using System.Runtime.InteropServices;

        public class Wallpaper {
            [DllImport("user32.dll", CharSet = CharSet.Auto)]
            public static extern int SystemParametersInfo(int uAction, int uParam, string lpvParam, int fuWinIni);
        }
        "@

        [Wallpaper]::SystemParametersInfo(0x0014, 0, $wallpaperPath, 0x0001)

        Write-Host "The wallpaper has been changed to a random image from the GitHub repository."
    } else {
        Write-Host "Exiting the wallpaper changer."
        break
    }
}
