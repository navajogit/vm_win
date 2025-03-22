# To be checked....
function Download-Ventoy {
    $url = "https://downloads.sourceforge.net/project/ventoy/v1.1.05/ventoy-1.1.05-windows.zip"
    $downloadPath = "$env:USERPROFILE\Downloads\ventoy.zip"
    $extractPath = "$env:USERPROFILE\Downloads\ventoy-1.1.05"

    Write-Host "Dwonloading Ventoy..."
    curl -L -o $downloadPath $url

    Write-Host "Unpacking Ventoy..."
    Expand-Archive -Path $downloadPath -DestinationPath $extractPath -Force
}

function Get-USBDrives {
    $usbDrives = Get-WmiObject -Class Win32_DiskDrive | Where-Object { $_.MediaType -eq 'Removable Media' }
    return $usbDrives
}

function Format-USBDrive {
    param (
        [string]$driveLetter
    )

    Write-Host "Formating $driveLetter... All data will be lost!"
    
    $formatCommand = "format $driveLetter /FS:NTFS /Q /Y"
    Invoke-Expression -Command $formatCommand
}

function Install-Ventoy {
    param (
        [string]$drive
    )

    $ventoyExePath = "$env:USERPROFILE\Downloads\ventoy-1.1.05\Ventoy2Disk.exe"

    Write-Host "Installing Ventoy on choosen drive ($drive)..."
    Start-Process -FilePath $ventoyExePath -ArgumentList "VTOYCLI", "/I", "/PhyDrive:$drive" -Wait
}

Download-Ventoy

$usbDrives = Get-USBDrives

if ($usbDrives.Count -eq 0) {
    Write-Host "No usb disks found"
    exit
}

Write-Host "Found disks:"
$usbDrives | ForEach-Object { Write-Host "$($_.DeviceID) - $($_.Model)" }

$usbDriveId = Read-Host "Insert disc number id ( \\\\.\\PhysicalDrive1)"

if ($usbDriveId -notmatch "^\\\\\\\\.\\\\PhysicalDrive\d+$") {
    Write-Host "Wrong numner. choose proper DeviceID."
    exit
}

Write-Host "Formating disk before installing Ventoy... All data will be lost!"

$confirm = Read-Host "Format $usbDriveId and install Ventoy? (Y/N)"
if ($confirm -ne 'Y') {
    Write-Host "Instalation aborted"
    exit
}

Format-USBDrive -driveLetter $usbDriveId

Install-Ventoy -drive $usbDriveId

Write-Host "Instalation complete!"
