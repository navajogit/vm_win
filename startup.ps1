# vm faster setup

# Function to download a file and check for success
function Download-File($url, $outputPath, $description) {
    Write-Host "Do you want to download $description? (Y/N)"
    $downloadChoice = Read-Host
    if ($downloadChoice -eq "Y" -or $downloadChoice -eq "y") {
        Write-Host "Downloading $description..."
        Invoke-WebRequest -Uri $url -OutFile $outputPath
        if ($?) {
            Write-Host "$description downloaded successfully."
        } else {
            Write-Host "Failed to download $description. Please try downloading it manually or run the script again."
            exit
        }
    } else {
        Write-Host "Skipping $description download."
    }
}

# Download and install portmaster-installer.exe
Download-File -url "https://updates.safing.io/latest/windows_amd64/packages/portmaster-installer.exe" -outputPath "$env:USERPROFILE\Downloads\portmaster-installer.exe" -description "portmaster-installer.exe"

# Add a delay between downloads
Start-Sleep -Seconds 2

# Download and install Windscribe_2.6.14.exe
Download-File -url "https://windscribe.com/install/desktop/windows/Windscribe_2.6.14.exe" -outputPath "$env:USERPROFILE\Downloads\Windscribe_2.6.14.exe" -description "Windscribe_2.6.14.exe"

# Add a delay between downloads
Start-Sleep -Seconds 2

# Download and install BraveBrowserSetup.exe
Download-File -url "https://laptop-updates.brave.com/latest/winx64/BraveBrowserSetup.exe" -outputPath "$env:USERPROFILE\Downloads\BraveBrowserSetup.exe" -description "BraveBrowserSetup.exe"

# Add a delay between downloads
Start-Sleep -Seconds 2

# Download and install Spice Guest Tools
Download-File -url "https://www.spice-space.org/download/windows/spice-guest-tools/spice-guest-tools-latest.exe" -outputPath "$env:USERPROFILE\Downloads\spice-guest-tools-latest.exe" -description "spice-guest-tools-latest.exe"

# Add a delay between downloads
Start-Sleep -Seconds 2

# Download and install Spice WebDAVd
Download-File -url "https://www.spice-space.org/download/windows/spice-webdavd/spice-webdavd-x64-latest.msi" -outputPath "$env:USERPROFILE\Downloads\spice-webdavd-x64-latest.msi" -description "spice-webdavd-x64-latest.msi"



# Prompt to run the program
$runProgram = Read-Host "Do you want to run the program from christitus.com? (Y/N)"
if ($runProgram -eq "Y" -or $runProgram -eq "y") {
    # Run the script from christitus.com
    Invoke-Expression (Invoke-WebRequest -Uri "https://christitus.com/win").Content
} else {
    Write-Host "The program was not executed."
}


# changing wallpaper with exteranal list of urls

# URL repozytorium GitHub zawierającego listę URL obrazków
$githubRepoUrl = "https://raw.githubusercontent.com/navajogit/vm_win/main/wallpapers_urls.txt"

# Pobierz zawartość pliku z listą URL obrazków i podziel na tablicę
$wallpaperUrls = (Invoke-RestMethod -Uri $githubRepoUrl -UseBasicParsing).Split([Environment]::NewLine, [StringSplitOptions]::RemoveEmptyEntries)

while ($true) {
    # Zapytaj użytkownika, czy chce zmienić tapetę
    $changeWallpaper = Read-Host "Do you want to change the desktop wallpaper? (Y/N)"
    if ($changeWallpaper -eq "Y" -or $changeWallpaper -eq "y") {
        # Wybierz losowy URL z listy
        $randomUrl = $wallpaperUrls | Get-Random

        # Ścieżka docelowa dla tapety w folderze tapet systemowych
        $wallpaperPath = "$env:USERPROFILE\AppData\Roaming\Microsoft\Windows\Themes\TranscodedWallpaper"

        # Pobierz losowy obrazek za pomocą wget
        Invoke-WebRequest -Uri $randomUrl -OutFile $wallpaperPath

        # Ustaw obrazek jako tapetę
        rundll32.exe user32.dll, UpdatePerUserSystemParameters

        Write-Host "The wallpaper has been changed to a random image from the GitHub repository."
    } else {
        Write-Host "Exiting the wallpaper changer."
        break
    }
}
