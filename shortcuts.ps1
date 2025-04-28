$ahkExe = "${env:ProgramFiles}\AutoHotkey\AutoHotkey.exe"
if (-Not (Test-Path $ahkExe)) {
    $ahkExe = "${env:ProgramFiles(x86)}\AutoHotkey\AutoHotkey.exe"
}
if (-Not (Test-Path $ahkExe)) {
    $url = "https://www.autohotkey.com/download/ahk-install.exe"
    $installer = "$env:TEMP\ahk-install.exe"
    Invoke-WebRequest -Uri $url -OutFile $installer
    Start-Process -FilePath $installer -ArgumentList "/S" -Wait
    Start-Sleep -Seconds 2
    $ahkExe = "${env:ProgramFiles}\AutoHotkey\AutoHotkey.exe"
    if (-Not (Test-Path $ahkExe)) {
        $ahkExe = "${env:ProgramFiles(x86)}\AutoHotkey\AutoHotkey.exe"
    }
    if (-Not (Test-Path $ahkExe)) { Write-Error "AutoHotkey install failed"; exit }
}

$ahkCode = @'
#q::Send !{F4}
#d::Send, #Tab
#f::Run explorer.exe  ; <-- This line is the new hotkey for opening the file explorer
return
'@

$ahkScriptPath = "$env:APPDATA\AutoHotkey\WinQ_CloseWindow.ahk"
if (-Not (Test-Path $ahkScriptPath)) {
    New-Item -ItemType Directory -Path (Split-Path $ahkScriptPath) -Force | Out-Null
    Set-Content -Path $ahkScriptPath -Value $ahkCode -Encoding UTF8
    Start-Process -FilePath $ahkExe -ArgumentList "`"$ahkScriptPath`""
}

$running = Get-Process | Where-Object { $_.ProcessName -eq 'AutoHotkey' }
$match = $false
if ($running) {
    $scripts = Get-CimInstance Win32_Process | Where-Object { $_.Name -eq 'AutoHotkey.exe' -and $_.CommandLine -match '#q::Send !{F4}' }
    if ($scripts) { $match = $true }
}
if (-Not $match) {
    $tempPath = "$env:TEMP\temp_win_q.ahk"
    Set-Content -Path $tempPath -Value $ahkCode -Encoding UTF8
    Start-Process -FilePath $ahkExe -ArgumentList "`"$tempPath`""
}

$shortcutPath = "$env:APPDATA\Microsoft\Windows\Start Menu\Programs\Startup\WinQ_CloseWindow.lnk"
if (-Not (Test-Path $shortcutPath)) {
    $WshShell = New-Object -ComObject WScript.Shell
    $Shortcut = $WshShell.CreateShortcut($shortcutPath)
    $Shortcut.TargetPath = $ahkExe
    $Shortcut.Arguments = "`"$ahkScriptPath`""
    $Shortcut.Save()
}
