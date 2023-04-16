$ProgressPreference = 'SilentlyContinue' 


winget uninstall cortana --accept-source-agreements --silent
winget uninstall skype --accept-source-agreements --silent
winget uninstall Microsoft.ZuneMusic_8wekyb3d8bbwe --accept-source-agreements --silent
winget uninstall disney+ --accept-source-agreements --silent
winget uninstall Clipchamp.Clipchamp_yxz26nhyzhsrt --accept-source-agreements --silent
winget uninstall 5319275A.WhatsAppDesktop_cv1g1gvanyjgm --accept-source-agreements --silent
winget uninstall SpotifyAB.SpotifyMusic_zpdnekdrzrea0 --accept-source-agreements --silent
winget uninstall Microsoft.Wallet_8wekyb3d8bbwe --accept-source-agreements --silent
winget uninstall Microsoft.Getstarted_8wekyb3d8bbwe --accept-source-agreements --silent
winget uninstall Microsoft.BingNews_8wekyb3d8bbwe --accept-source-agreements --silent
winget uninstall MicrosoftTeams_8wekyb3d8bbwe --accept-source-agreements --silent
winget uninstall MicrosoftCorporationII.MicrosoftFamily_8wekyb3d8bbwe --accept-source-agreements --silent
winget uninstall MicrosoftCorporationII.QuickAssist_8wekyb3d8bbwe --accept-source-agreements --silent
winget uninstall 9NBLGGH42THS --accept-source-agreements --silent
winget uninstall Microsoft.3DBuilder_8wekyb3d8bbwe --accept-source-agreements --silent
winget uninstall Microsoft.MicrosoftSolitaireCollection_8wekyb3d8bbwe --accept-source-agreements --silent
winget uninstall 9NBLGGH5FV99 --accept-source-agreements --silent

# Remove Chat from Taskbar
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "TaskbarMn" -type "Dword" -Value "0"

# Remove Widgets from Taskbar
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "TaskbarDa" -type "Dword" -Value "0"

Write-Output "Enabling File Extenstions" -ForegroundColor Red
$ExpPath = "HKCU:Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"
if (Test-Path $ExpPath) {
    Set-ItemProperty -Path $ExpPath -Name HideFileExt -Value 0
}

Write-Output "Setting Mixed Reality Portal value to 0 so that you can uninstall it in Settings"
$Holo = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Holographic"    
If (Test-Path $Holo) {
    Set-ItemProperty $Holo  FirstRunSucceeded -Value 0 
}

$explorerPath = "HKCU:Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"

Write-Host "Setting Start Menu to Left" -ForegroundColor Red
if(Test-Path $explorerPath) {
    Set-ItemProperty -Path $explorerPath -Name TaskbarAl -Value 0
}
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AdvertisingInfo" -Name "DisabledByGroupPolicy" -Type DWord -Value 1
$checkStart = Get-ItemProperty -Path $explorerPath -Name TaskbarAl
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System" -Name "EnableActivityFeed" -Type DWord -Value 0
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System" -Name "PublishUserActivities" -Type DWord -Value 0
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System" -Name "UploadUserActivities" -Type DWord -Value 0

#Turns off Data Collection via the Allow Telemetry key by changing it to 0
Write-Output "Turning off Data Collection"
$DataCollection1 = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection"
$DataCollection2 = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection"
$DataCollection3 = "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Policies\DataCollection"    
If (Test-Path $DataCollection1) {
    Set-ItemProperty $DataCollection1  AllowTelemetry -Value 0 
}
If (Test-Path $DataCollection2) {
    Set-ItemProperty $DataCollection2  AllowTelemetry -Value 0 
}
If (Test-Path $DataCollection3) {
    Set-ItemProperty $DataCollection3  AllowTelemetry -Value 0 
}

#Disabling Location Tracking
Write-Output "Disabling Location Tracking"
$SensorState = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Sensor\Overrides\{BFA794E4-F964-4FDB-90F6-51056BFE4B44}"
$LocationConfig = "HKLM:\SYSTEM\CurrentControlSet\Services\lfsvc\Service\Configuration"
If (!(Test-Path $SensorState)) {
    New-Item $SensorState
}
Set-ItemProperty $SensorState SensorPermissionState -Value 0 
If (!(Test-Path $LocationConfig)) {
    New-Item $LocationConfig
}
Set-ItemProperty $LocationConfig Status -Value 0 

#Removes 3D Objects from the 'My Computer' submenu in explorer
Write-Host "Removing 3D Objects from explorer 'My Computer' submenu"
$Objects32 = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{0DB7E03F-FC29-4DC6-9020-FF41B59E513A}"
$Objects64 = "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{0DB7E03F-FC29-4DC6-9020-FF41B59E513A}"
If (Test-Path $Objects32) {
    Remove-Item $Objects32 -Recurse
}
If (Test-Path $Objects64) {
    Remove-Item $Objects64 -Recurse 
}

