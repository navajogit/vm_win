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
