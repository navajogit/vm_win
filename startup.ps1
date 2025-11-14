$scriptDir = "$env:SystemDrive\scripts"

# Funkcja sprawdzająca, czy skrypt jest uruchomiony z uprawnieniami administratora
function Check-Administrator {
    if (-not (Test-Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System")) {
        Write-Host "Uruchom ten skrypt jako Administrator!" -ForegroundColor Red
        exit
    }
}

# Funkcja do instalacji aliasu i skryptów
function Install-UnpackAlias {
    # Tworzenie folderu na skrypty, jeśli nie istnieje
    if (-not (Test-Path $scriptDir)) {
        New-Item -Path $scriptDir -ItemType Directory
    }

    # Tworzenie pliku unpack.bat (dla CMD)
    @"
    @echo off
    :: Skrypt unpack.bat - działa w CMD
    tar -xf %1 -C .
    "@ | Set-Content -Path "$scriptDir\unpack.bat"

    # Tworzenie pliku unpack.ps1 (dla PowerShell)
    @"
    param([string]`$zipFile)
    tar -xf `\$zipFile -C .
    "@ | Set-Content -Path "$scriptDir\unpack.ps1"

    # Dodanie folderu skryptów do zmiennej PATH (dla wszystkich użytkowników)
    $pathValue = [System.Environment]::GetEnvironmentVariable('PATH', [System.EnvironmentVariableTarget]::Machine)
    if ($pathValue -notcontains $scriptDir) {
        $newPathValue = $pathValue + ";$scriptDir"
        [System.Environment]::SetEnvironmentVariable('PATH', $newPathValue, [System.EnvironmentVariableTarget]::Machine)
    }

    # Dodanie aliasu do PowerShell dla bieżącego użytkownika
    $profileDir = "$env:USERPROFILE\Documents\WindowsPowerShell"
    if (-not (Test-Path $profileDir)) {
        New-Item -Path $profileDir -ItemType Directory
    }
    "Set-Alias unpack '$scriptDir\unpack.ps1'" | Add-Content -Path "$profileDir\Microsoft.PowerShell_profile.ps1"

    Write-Host "Instalacja aliasu 'unpack' zakończona. Skrypt jest teraz dostępny w CMD i PowerShell."
    Write-Host "Aby użyć, otwórz nową sesję PowerShell lub CMD."
}

# Funkcja do pobierania plików
function Download-Files {
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
                Write-Host "Failed to download $($fileInfo.Description)."
            }
        }
    } else {
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
                    Write-Host "Failed to download $($fileInfo.Description)."
                }
            } else {
                Write-Host "Skipping $($fileInfo.Description)."
            }
        }
    }
}

# Funkcja do pobierania innych plików
function Download-OtherFiles {
    $OtherfilesToDownload = @(
        @{
            Url = "https://launchpad.net/veracrypt/trunk/1.26.20/+download/VeraCrypt%20Setup%201.26.20.exe"
            Description = "VeraCryptSetup 1.26.20.exe"
        },
        @{
            Url = "https://github.com/git-for-windows/git/releases/download/v2.49.0.windows.1/Git-2.49.0-64-bit.exe"
            Description = "Git-2.49.0-64-bit.exe"
        },
        @{
            Url = "https://web.archive.org/web/20240428012709/https://www.aescrypt.com/download/v3/windows/AESCrypt_v310_x64.zip"
            Description = "AESCrypt_v310_x64.zip"
        },
        @{
            Url = "https://web.archive.org/web/20240428012611/https://www.aescrypt.com/download/v3/windows/AESCrypt_console_v310_x64.zip"
            Description = "AESCrypt_console_v310_x64.zip"
        }
    )

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
                Write-Host "Failed to download $($fileInfo.Description)."
            }
        }
    } else {
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
                    Write-Host "Failed to download $($fileInfo.Description)."
                }
            } else {
                Write-Host "Skipping $($fileInfo.Description)."
            }
        }
    }
}

# Główne menu
Write-Host "Wybierz opcję:"
Write-Host "1. Zainstaluj alias unpack"
Write-Host "2. Pobierz podstawowe pliki"
Write-Host "3. Pobierz dodatkowe pliki"
Write-Host "4. Zakończ"

$choice = Read-Host "Wprowadź numer opcji"

switch ($choice) {
    1 {
        Check-Administrator
        Install-UnpackAlias
        break
    }
    2 {
        Download-Files
        break
    }
    3 {
        Download-OtherFiles
        break
    }
    4 {
        Write-Host "Kończę..."
        break
    }
    default {
        Write-Host "Nieprawidłowa opcja. Spróbuj ponownie."
        break
    }
}
