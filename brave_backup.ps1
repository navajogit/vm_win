# Locate the Brave browser profile folder
$braveProfilePath = Get-ChildItem "$env:LOCALAPPDATA\BraveSoftware\Brave-Browser\User Data" | Where-Object { $_.Name -eq "Default" } | Select-Object -ExpandProperty FullName

if ($braveProfilePath -eq $null) {
    Write-Host "Unable to find the Brave browser profile folder."
    exit
}

# Create a folder on the desktop for exporting settings
$exportFolder = Join-Path -Path $env:USERPROFILE\Desktop -ChildPath "BraveSettingsBackup"
New-Item -ItemType Directory -Path $exportFolder -Force

# Configuration files to export
$settingsFiles = "Preferences", "Secure Preferences"

# Copy configuration files to the export folder
foreach ($file in $settingsFiles) {
    $sourceFilePath = Join-Path -Path $braveProfilePath -ChildPath $file
    $destinationFilePath = Join-Path -Path $exportFolder -ChildPath $file
    Copy-Item -Path $sourceFilePath -Destination $destinationFilePath -Force
}

Write-Host "Brave browser settings have been exported to the 'BraveSettingsBackup' folder on your desktop."
