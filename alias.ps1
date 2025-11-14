$scriptDir = "$env:SystemDrive\scripts"

# Sprawdzenie, czy skrypt jest uruchomiony z uprawnieniami administratora
if (-not (Test-Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System")) {
    Write-Host "Uruchom ten skrypt jako Administrator!" -ForegroundColor Red
    exit
}

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

Write-Host "Instalacja zakończona. Skrypt 'unpack' jest teraz dostępny w CMD i PowerShell."
Write-Host "Aby użyć, otwórz nową sesję PowerShell lub CMD."

