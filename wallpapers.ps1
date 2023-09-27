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
