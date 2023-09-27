# changing wallpaper with exteranal list of urls

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

