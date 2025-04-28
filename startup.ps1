$filesToDownload = @(
    @{
        Url = "https://updates.safing.io/latest/windows_amd64/packages/Firewall - portmaster-installer.exe"
        Description = "portmaster-installer.exe"
    },
    @{
        Url = "https://windscribe.com/install/desktop/windows/Windscribe_2.14.12.exe"
        Description = "Windscribe_2.14.12.exe"
    },
    @{
        Url = "https://laptop-updates.brave.com/latest/winx64/BraveBrowserSetup.exe"
        Description = "BraveBrowserSetup.exe"
    },
    @{
        Url = "https://www.spice-space.org/download/windows/spice-guest-tools/spice-guest-tools-latest.exe"
        Description = "spice-guest-tools-latest.exe"
    },
    @{
        Url = "https://www.spice-space.org/download/windows/spice-webdavd/spice-webdavd-x64-latest.msi"
        Description = "spice-webdavd-x64-latest.msi"
    },
    @{
        Url = "https://www.clamav.net/downloads/production/clamav-1.4.2.win.x64.msi"
        Description = "clamav-1.4.2.win.x64.msi"
    },
    @{
        Url = "https://dist.torproject.org/torbrowser/13.5a11/tor-browser-windows-x86_64-portable-13.5a11.exe"
        Description = "tor-browser-windows-x86_64-portable-13.5a11.exe"
    }
)

# Display descriptions of all files
Write-Host "Available basic startup files to download:"
$filesToDownload | ForEach-Object {
    Write-Host "$($_.Description)"
}

# Ask the user if they want to download all files at once.
Write-Host "Do you want to download all available basic startup files at once? (Y/N)"
$downloadAll = Read-Host
if ($downloadAll -eq "Y" -or $downloadAll -eq "y") {
    foreach ($fileInfo in $filesToDownload) {
        Write-Host "Downloading $($fileInfo.Description)..."
        $outputPath = "$env:USERPROFILE\Downloads\$($fileInfo.Description)"
        Invoke-WebRequest -Uri $fileInfo.Url -OutFile $outputPath
        if ($?) {
            Write-Host "$($fileInfo.Description) downloaded successfully."
        } else {
            Write-Host "Failed to download $($fileInfo.Description). Please try downloading it manually or run the script again."
            exit
        }
    }
} else {
    # Loop through the list of files and ask the user whether to download each one
    foreach ($fileInfo in $filesToDownload) {
        Write-Host "Do you want to download $($fileInfo.Description)? (Y/N)"
        $downloadChoice = Read-Host
        if ($downloadChoice -eq "Y" -or $downloadChoice -eq "y") {
            Write-Host "Downloading $($fileInfo.Description)..."
            $outputPath = "$env:USERPROFILE\Downloads\$($fileInfo.Description)"
            Invoke-WebRequest -Uri $fileInfo.Url -OutFile $outputPath
            if ($?) {
                Write-Host "$($fileInfo.Description) downloaded successfully."
            } else {
                Write-Host "Failed to download $($fileInfo.Description). Please try downloading it manually or run the script again."
                exit
            }
        } else {
            Write-Host "Skipping $($fileInfo.Description) download."
        }
    }
}



# tweaks

# Prompt to run the program
$runProgram = Read-Host "Do you want to run the program from christitus.com? (Y/N)"
if ($runProgram -eq "Y" -or $runProgram -eq "y") {
    # Run the script from christitus.com
    Invoke-Expression (Invoke-WebRequest -Uri "https://christitus.com/win").Content
} else {
    Write-Host "The program was not executed."
}


# changing wallpaper with external list of URLs

# URL with wallpaper list
$githubRepoUrl = "https://raw.githubusercontent.com/navajogit/vm_win/main/wallpapers_urls.txt"

# Get wallpapers list and setup
$wallpaperUrls = (Invoke-RestMethod -Uri $githubRepoUrl -UseBasicParsing).Split([Environment]::NewLine, [StringSplitOptions]::RemoveEmptyEntries)

while ($true) {
    $changeWallpaper = Read-Host "Do you want to change the desktop wallpaper? (Y/N)"
    if ($changeWallpaper -eq "Y" -or $changeWallpaper -eq "y") {
        # Set random 
        $randomUrl = $wallpaperUrls | Get-Random
        # path
        $wallpaperPath = "$env:USERPROFILE\AppData\Roaming\Microsoft\Windows\Themes\TranscodedWallpaper"

        # Downloading with wget
        Invoke-WebRequest -Uri $randomUrl -OutFile $wallpaperPath

        # Set picture as wallpaper
        rundll32.exe user32.dll, UpdatePerUserSystemParameters

        # Additinal refress through registry
        $regKey = "HKCU:\Control Panel\Desktop"
        Set-ItemProperty -Path $regKey -Name Wallpaper -Value $wallpaperPath
        Set-ItemProperty -Path $regKey -Name WallpaperStyle -Value 2 # 2 - Tiling, 0 - Centered, 6 - Stretched (optionally modify)
        # referesh
        rundll32.exe user32.dll, UpdatePerUserSystemParameters

        Write-Host "The wallpaper has been changed to a random image from the GitHub repository."
    } else {
        Write-Host "Exiting the wallpaper changer."
        break
    }
}



$OtherfilesToDownload = @(
    @{
        Url = "https://launchpad.net/veracrypt/trunk/1.26.7/+download/VeraCrypt%20Setup%201.26.7.exe"
        Description = "VeraCryptSetup 1.26.7.exe"
    },
    @{
        Url = "https://github.com/git-for-windows/git/releases/download/v2.42.0.windows.2/Git-2.42.0.2-64-bit.exe"
        Description = "Git-2.42.0.2-64-bit.exe"
    },
    @{
        # Url = "https://www.aescrypt.com/download/v3/windows/AESCrypt_v310_x64.zip"
        Url = "https://web.archive.org/web/20240428012709/https://www.aescrypt.com/download/v3/windows/AESCrypt_v310_x64.zip"
        Description = "AESCrypt_v310_x64.zip"
        
    },
    @{
        # Url = "https://www.aescrypt.com/download/v3/windows/AESCrypt_console_v310_x64.zip"
        Url = "https://web.archive.org/web/20240428012611/https://www.aescrypt.com/download/v3/windows/AESCrypt_console_v310_x64.zip"
        Description = "AESCrypt_console_v310_x64.zip"
    }
)

# Display descriptions of all files
Write-Host "Available additional files to download:"
$OtherfilesToDownload | ForEach-Object {
    Write-Host "$($_.Description)"
}

# Ask the user if they want to download all files at once.
Write-Host "Do you want to download all available additional files at once? (Y/N)"
$downloadAll = Read-Host
if ($downloadAll -eq "Y" -or $downloadAll -eq "y") {
    foreach ($fileInfo in $OtherfilesToDownload) {
        Write-Host "Downloading $($fileInfo.Description)..."
        $outputPath = "$env:USERPROFILE\Downloads\$($fileInfo.Description)"
        Invoke-WebRequest -Uri $fileInfo.Url -OutFile $outputPath
        if ($?) {
            Write-Host "$($fileInfo.Description) downloaded successfully."
        } else {
            Write-Host "Failed to download $($fileInfo.Description). Please try downloading it manually or run the script again."
            exit
        }
    }
} else {
    # Loop through the list of files and ask the user whether to download each one
    foreach ($fileInfo in $OtherfilesToDownload) {
        Write-Host "Do you want to download $($fileInfo.Description)? (Y/N)"
        $downloadChoice = Read-Host
        if ($downloadChoice -eq "Y" -or $downloadChoice -eq "y") {
            Write-Host "Downloading $($fileInfo.Description)..."
            $outputPath = "$env:USERPROFILE\Downloads\$($fileInfo.Description)"
            Invoke-WebRequest -Uri $fileInfo.Url -OutFile $outputPath
            if ($?) {
                Write-Host "$($fileInfo.Description) downloaded successfully."
            } else {
                Write-Host "Failed to download $($fileInfo.Description). Please try downloading it manually or run the script again."
                exit
            }
        } else {
            Write-Host "Skipping $($fileInfo.Description) download."
        }
    }
}
