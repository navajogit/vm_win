# URL z listą tapet
$githubRepoUrl = "https://raw.githubusercontent.com/navajogit/vm_win/main/wallpapers_urls.txt"

# Pobierz listę tapet
$wallpaperUrls = (Invoke-RestMethod -Uri $githubRepoUrl -UseBasicParsing).Split([Environment]::NewLine, [StringSplitOptions]::RemoveEmptyEntries)

function Set-Wallpaper($path) {
    $code = @"
using System.Runtime.InteropServices;
namespace Wallpaper {
    public class Setter {
        [DllImport("user32.dll", SetLastError = true)]
        public static extern bool SystemParametersInfo(int uAction, int uParam, string lpvParam, int fuWinIni);
    }
}
"@
    Add-Type $code

    # Ustawienia "Fit" — zachowanie proporcji z czarnym tłem
    $regKey = "HKCU:\Control Panel\Desktop"
    Set-ItemProperty -Path $regKey -Name Wallpaper -Value $path
    Set-ItemProperty -Path $regKey -Name WallpaperStyle -Value 6  # Fit
    Set-ItemProperty -Path $regKey -Name TileWallpaper -Value 0

    # Wymuszenie odświeżenia tapety
    [Wallpaper.Setter]::SystemParametersInfo(20, 0, $path, 0x01 -bor 0x02)
}

while ($true) {
    $input = Read-Host "`nHIT ENTER TO CHANGE WALLPAPER or any other key then ENTER to exit"
    if ($input -eq "") {
        $randomUrl = $wallpaperUrls | Get-Random
        $wallpaperPath = "$env:TEMP\wallpaper_$(Get-Random).jpg"
        Invoke-WebRequest -Uri $randomUrl -OutFile $wallpaperPath -UseBasicParsing

        Set-Wallpaper -path $wallpaperPath
        Write-Host "`n✔ Wallpaper changed to: $randomUrl (with 'Fit' mode — preserved proportions)"
    } else {
        Write-Host "`nExiting wallpaper changer."
        break
    }
}
